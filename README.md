# Custom-TestNet-Depolyment
Deploy a custom ERC-20 smart contract to the BlockDAG Primordial Testnet using thirdweb's TypeScript SDK with automatic fallback to ethers.js.. This dual method ensures reliable deployment and compatibility with custom EVM networks.

# BlockDAG Smart Contract Deployment (thirdweb + ethers.js)

This repository provides a TypeScript script to deploy a custom smart contract to the BlockDAG Primordial Testnet. It leverages both [thirdweb](https://portal.thirdweb.com/typescript) and [ethers.js](https://docs.ethers.org/) for maximum flexibility and reliability.

---

## Features

- **OpenZeppelin Integration:** Start from secure, audited contract templates.
- **Remix Workflow:** Compile and export ABI/bytecode easily.
- **Custom Chain Support:** Deploy to BlockDAG or any EVM-compatible network.
- **Dual Deployment Strategy:** Tries thirdweb SDK, falls back to ethers.js if needed.
- **Constructor Parameters:** Supports contracts with constructor arguments.
- **Gas Customization:** Set custom gas limits and fees.

---

## Prerequisites

- Node.js (v18+ recommended)
- A funded private key for BlockDAG Primordial Testnet
- Contract ABI and bytecode (from Remix, Hardhat, or Foundry)

---

## 1. Create Your Contract with OpenZeppelin

1. Visit [OpenZeppelin Contracts Wizard](https://wizard.openzeppelin.com/).
2. Select your contract type (e.g., ERC20, ERC721, Ownable, etc.).
3. Configure features (mintable, burnable, etc.).
4. Click **"Open in Remix"** to load your contract in Remix IDE.

---

## 2. Compile and Export ABI/Bytecode with Remix

1. In [Remix IDE](https://remix.ethereum.org/), open your contract file.
2. Go to the **Solidity Compiler** tab and click **Compile**.
3. Click the **"Compilation Details"** button (the circled "i" icon).
4. In the popup, scroll to **"Bytecode"** and **"ABI"**:
    - Click the copy button next to each and save them in your project as `bytecode` and `abi` variables in your deployment script.

---

## 3. Configure Your Deployment Script

- Replace the `bytecode` and `abi` variables in `deploy.js` with the values you copied from Remix.
- Set your private key and thirdweb client ID.
- Update constructor parameters as needed.

---

## 4. Install Dependencies

```bash
npm init -y
npm install thirdweb ethers
node deploy.mjs or [ deploy.js (Change "type" :module , --- package.json) ]
npm install
