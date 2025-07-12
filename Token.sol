/**
 * BlockDAG Smart Contract Deployment Script
 *
 * Deploys a contract to BlockDAG Primordial Testnet using thirdweb and ethers.js.
 * - Attempts deployment with thirdweb SDK first, falls back to ethers.js if needed.
 * - Reads sensitive data from environment variables.
 *
 * Usage:
 * 1. Copy your ABI and bytecode from Remix (see README for instructions).
 * 2. Create a `.env` file with your PRIVATE_KEY and THIRDWEB_CLIENT_ID.
 * 3. Run: `npm install dotenv ethers thirdweb`
 * 4. Run: `node deploy.js`
 */

import "dotenv/config";
import { createThirdwebClient } from "thirdweb";
import { defineChain } from "thirdweb/chains";
import { privateKeyToAccount } from "thirdweb/wallets";
import { ethers } from "ethers";

// 1. Define your custom chain
const blockdagTestnet = defineChain({
  id: 1043,
  name: "BlockDAG Primordial Testnet",
  rpc: "https://rpc.primordial.bdagscan.com",
  nativeCurrency: {
    name: "BlockDAG",
    symbol: "BDAG",
    decimals: 18,
  },
  blockExplorers: [
    {
      name: "BlockDAG Explorer",
      url: "https://primordial.bdagscan.com",
    },
  ],
});

// 2. Set up your client and account (read from .env)
const client = createThirdwebClient({
  clientId: process.env.THIRDWEB_CLIENT_ID, // Set in .env
});

const account = privateKeyToAccount({
  client,
  privateKey: process.env.PRIVATE_KEY, // Set in .env
});

// 3. Contract ABI and bytecode (replace with your own from Remix)
const abi = [
  /* ... ABI array ... */
];
const bytecode = "0x..."; // <-- Paste your full bytecode from Remix here (The bytecode should look like this: javascriptconst bytecode = "0x608060405234801561001057600080fd)

// 4. Deployment with ethers.js (fallback)
async function deployWithEthers() {
  try {
    console.log("Starting deployment with ethers.js...");
    const provider = new ethers.JsonRpcProvider(
      blockdagTestnet.rpc,
    );
    const wallet = new ethers.Wallet(
      process.env.PRIVATE_KEY,
      provider,
    );

    const contractFactory = new ethers.ContractFactory(
      abi,
      bytecode,
      wallet,
    );

    const contract = await contractFactory.deploy(
      "0xYourRecipientAddress", // recipient
      "0xYourInitialOwnerAddress", // initialOwner
      {
        gasLimit: 7000000,
        maxFeePerGas: ethers.parseUnits("10", "gwei"),
        maxPriorityFeePerGas: ethers.parseUnits(
          "2",
          "gwei",
        ),
      },
    );

    console.log(
      "Transaction hash:",
      contract.deploymentTransaction().hash,
    );
    console.log("Waiting for deployment...");
    await contract.waitForDeployment();

    const contractAddress = await contract.getAddress();
    console.log(
      "✅ Contract deployed at:",
      contractAddress,
    );
    console.log(
      "🔗 View on explorer:",
      `https://primordial.bdagscan.com/address/${contractAddress}`,
    );
    return contractAddress;
  } catch (error) {
    console.error("❌ Deployment failed:", error);
    throw error;
  }
}

// 5. Try thirdweb deployment, fallback to ethers.js if needed
async function main() {
  try {
    console.log("Attempting Thirdweb deployment...");
    const { deployContract } = await import(
      "thirdweb/deploys"
    );

    const contractAddress = await deployContract({
      client,
      account,
      chain: blockdagTestnet,
      abi,
      bytecode,
      constructorParams: [
        "0xYourRecipientAddress", // recipient
        "0xYourInitialOwnerAddress", // initialOwner
      ],
      overrides: {
        gasLimit: 7000000,
        maxFeePerGas: ethers.parseUnits("10", "gwei"),
        maxPriorityFeePerGas: ethers.parseUnits(
          "2",
          "gwei",
        ),
      },
    });

    console.log("✅ Thirdweb deployment successful!");
    console.log("🔗 Contract address:", contractAddress);
    console.log(
      "🔗 View on explorer:",
      `https://primordial.bdagscan.com/address/${contractAddress}`,
    );
  } catch (error) {
    console.log(
      "❌ Thirdweb deployment failed, trying ethers.js...",
    );
    console.error("Thirdweb error:", error);
    await deployWithEthers();
  }
}

main().catch(console.error);
