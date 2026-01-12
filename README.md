# Builder's Forge

**The ultimate full-stack starter kit for Farcaster Mini Apps.**

This repository combines a production-ready Next.js frontend with a robust Foundry smart contract environment. It is designed to get you from "zero" to "deployed dApp" as fast as possible.

## Quick Start

### 1. Clone and Install
```bash
git clone https://github.com/hurley87/builders-forge.git
cd builders-forge

# Install Frontend dependencies
npm install

# Install Smart Contract dependencies
cd contracts && forge install && cd ..
```

### 2. Environment Setup

You will need environment variables for both the frontend (Next.js) and the contracts (Foundry).

- **Frontend**: Copy `.env.example` to `.env.local` and add your Farcaster/WalletConnect keys.
- **Contracts**: Create a `.env` file inside the `contracts/` folder for your RPC URLs and Private Keys (see `contracts/.env.example`).

### 3. Start Hacking

**Run the Frontend:**
```bash
npm run dev
```
Open http://localhost:3000 to see your Mini App.

**Run Contracts:**
```bash
npm run forge:test
```

## Architecture

This is a "Monorepo-Lite" setup. Everything lives in one place, but concerns are separated:

- `app/` (Frontend): The Next.js application, powered by the Farcaster Mini App Starter.
- `contracts/` (Backend): The Smart Contract environment, powered by LazerForge.

### Available Commands

Run these from the root directory:

| Command | Description |
|---------|-------------|
| `npm run dev` | Starts the Next.js local development server. |
| `npm run forge:build` | Compiles your smart contracts. |
| `npm run forge:test` | Runs Foundry tests for your contracts. |
| `npm run forge:deploy` | Deploys contracts and syncs ABIs to the frontend. |

**Note**: Check `package.json` to configure the deployment script specific to your chain.

## Tribute & Credits

Builder's Forge stands on the shoulders of giants. It is a remix of two incredible open-source projects:

- **Frontend**: [Farcaster Mini App Starter](https://github.com/builders-garden/miniapp-starter) by Builders Garden.
- **Smart Contracts**: [LazerForge](https://github.com/lazertechnologies/lazerforge) by Lazer Technologies.

Please support the original creators by starring their repositories!

## License

This project retains the open-source licenses of its parent components. See the LICENSE file in the root and `contracts/` directory for details.
