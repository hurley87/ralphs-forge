# Builder's Forge

**The ultimate full-stack starter kit for Farcaster Mini Apps.**

This repository combines a production-ready Next.js frontend with a robust Foundry smart contract environment. It is designed to get you from "zero" to "deployed dApp" as fast as possible.

## Quick Start

### 1. Clone and Install
```bash
git clone https://github.com/hurley87/ralphs-forge.git
cd ralphs-forge

# Install Frontend dependencies
npm install

# Install Smart Contract dependencies
cd contracts && forge install && cd ..
```

### 2. Environment Setup

You will need environment variables for both the frontend (Next.js) and the contracts (Foundry).

**Frontend**: Copy `.env.example` to `.env.local`:
```bash
cp .env.example .env.local
```

Then fill in the required values:

| Variable | How to get it |
|----------|---------------|
| `JWT_SECRET` | Generate a random string: `openssl rand -hex 32` |
| `NEXT_PUBLIC_URL` | Your app URL (`http://localhost:3000` for local dev) |
| `NEYNAR_API_KEY` | Sign up at [neynar.com](https://neynar.com) and get an API key |
| `REDIS_URL` / `REDIS_TOKEN` | Create a free Redis database at [upstash.com](https://upstash.com) |
| `NEXT_PUBLIC_FARCASTER_HEADER` | Frame account association (see below) |
| `NEXT_PUBLIC_FARCASTER_PAYLOAD` | Frame account association (see below) |
| `NEXT_PUBLIC_FARCASTER_SIGNATURE` | Frame account association (see below) |

**Farcaster Account Association**: The `NEXT_PUBLIC_FARCASTER_*` variables come from signing your app's domain with your Farcaster account. Generate them using the [Warpcast Developer Manifest tool](https://warpcast.com/~/developers/manifest) or follow the [Mini App docs](https://docs.farcaster.xyz/developers/guides/miniapps).

**Quick start for local dev**: If you just want to test without full Farcaster integration, use placeholder values for the Farcaster variables initially. The Neynar and Redis credentials are the main ones needed for auth to work.

**Contracts**: Create a `.env` file inside the `contracts/` folder for your RPC URLs and Private Keys (see `contracts/.env.example`).

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
| `npm run ralph` | Runs the autonomous development loop (see below). |

**Note**: Check `package.json` to configure the deployment script specific to your chain.

## Ralph: Autonomous Development Loop

Ralph is an autonomous coding agent powered by Claude. It works through a generated implementation plan, writing code, running tests, and committing changes without human intervention.

### How It Works

1. **Generate a Plan**: Use the `/blueprint` slash command in Claude Code to create an implementation plan.
   ```bash
   /blueprint Add a voting contract with a frontend UI
   ```
   This creates a task checklist in `ralph/IMPLEMENTATION_PLAN.md`.

2. **Run Ralph**: Execute the autonomous loop.
   ```bash
   npm run ralph        # Default: 10 iterations
   npm run ralph 20     # Custom: 20 iterations
   ```

Ralph will:
- Pick the next unchecked task from the plan
- Write the code and run verification (`forge test` or `npm run lint`)
- Mark the task complete and commit
- Exit and restart for the next task

### Key Principle: Contracts First

Ralph enforces a strict ordering: **all smart contract tasks must complete before frontend tasks begin**. This ensures ABIs exist before the frontend tries to import them.

## Tribute & Credits

Builder's Forge stands on the shoulders of giants. It is a remix of these open-source projects:

- **Frontend**: [Farcaster Mini App Starter](https://github.com/builders-garden/miniapp-starter) by Builders Garden.
- **Smart Contracts**: [LazerForge](https://github.com/lazertechnologies/lazerforge) by Lazer Technologies.
- **Ralph**: [How to Ralph Wiggum](https://github.com/ghuntley/how-to-ralph-wiggum) by Geoffrey Huntley.

Please support the original creators by starring their repositories!

## License

This project retains the open-source licenses of its parent components. See the LICENSE file in the root and `contracts/` directory for details.
