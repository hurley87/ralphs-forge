# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Builder's Forge is a full-stack starter kit for Farcaster Mini Apps. It combines a Next.js frontend (from Farcaster Mini App Starter by Builders Garden) with a Foundry smart contract environment (from LazerForge by Lazer Technologies).

## Commands

### Frontend Development
```bash
npm run dev       # Start Next.js dev server
npm run build     # Build production bundle
npm run lint      # Run ESLint
```

### Smart Contracts
```bash
npm run forge:build   # Compile contracts
npm run forge:test    # Run Foundry tests
npm run forge:deploy  # Deploy and sync ABI to frontend

# Direct Foundry commands (from contracts/ directory)
forge test -vvv                    # Verbose test output
forge test --match-test testName   # Run specific test
forge test --match-contract Name   # Run tests in specific contract
forge snapshot                     # Generate gas snapshots
FOUNDRY_PROFILE=CI forge test      # Run with CI profile (more fuzz runs)
```

## Architecture

### Frontend Stack
- **Next.js 16** with App Router (React Server Components)
- **React 19** with TypeScript
- **Tailwind CSS** for styling
- **Wagmi/Viem** for wallet connections
- **React Query** for data fetching

### Farcaster Integration
The app detects its environment and behaves differently:
- **In Farcaster Mini App**: Full Mini App SDK features, native auth
- **In Browser**: Shows landing page with QR code and launch buttons

Key Farcaster packages: `@farcaster/miniapp-sdk`, `@farcaster/quick-auth`, `@farcaster/miniapp-wagmi-connector`

### Provider Architecture (components/providers/index.tsx)
Layered providers wrap the app in order:
1. `EnvironmentProvider` - Browser vs Mini App detection
2. `ErudaProvider` - Mobile debugging (dev only)
3. `WagmiProvider` - Wallet management
4. `QueryClientProvider` - React Query
5. `FarcasterProvider` - Mini App SDK
6. `UserProvider` - Auth state

### Context Hooks
- `useEnvironment()` - `isInBrowser`, `isInFarcasterMiniApp`, `isLoading`
- `useFarcaster()` - Mini App context, capabilities, safe area insets
- `useUser()` - User data, sign-in methods, auth state

### API Integration
Custom hooks in `/hooks/`:
- `useApiQuery` - GET requests with auth support
- `useApiMutation` - POST/PUT/DELETE with optimistic updates

### Authentication Flow
JWT-based auth using Farcaster Quick Auth:
- `/api/auth/sign-in` - Verify user identity
- `/api/auth/check` - Validate session
- `/api/users/me` - Get user profile (protected)

### Smart Contracts (contracts/)
Foundry-based with batteries included:
- **Solidity 0.8.28** with high optimizer settings
- **Dependencies**: OpenZeppelin, Solady, Uniswap v2/v3/v4
- **Deterministic testing**: Fixed block number (17722462) and timestamp

Foundry profiles:
- `default` - Standard dev with gas optimizations
- `CI` - More fuzz runs (1024)
- `via_ir` - Slow but highly optimized compilation
- `anvil` - Local testing with Prague EVM

### Key Directories

**Frontend (app/)**
```
app/api/        # API routes (auth, users, webhooks, notifications)
components/     # React components (pages/, providers/, shared/)
contexts/       # React contexts (environment, farcaster, user)
hooks/          # Custom hooks (useApiQuery, useApiMutation)
lib/            # Utils (env.ts with Zod validation, wagmi config, etc.)
```

**Smart Contracts (contracts/)**
```
contracts/src/      # Contract source files
contracts/test/     # Foundry tests
contracts/script/   # Deployment scripts
contracts/lib/      # Dependencies (git submodules)
```

## Environment Variables

Required (see .env.example):
- `NEXT_PUBLIC_URL` - App URL for frame metadata
- `NEXT_PUBLIC_FARCASTER_HEADER/PAYLOAD/SIGNATURE` - Frame account association
- `NEYNAR_API_KEY`, `JWT_SECRET` - Authentication
- `REDIS_URL`, `REDIS_TOKEN` - Notifications (Upstash)

For contracts deployment, set RPC URLs and API keys in environment.

## Solidity Import Remappings

Available imports in contracts:
```solidity
import "@openzeppelin/contracts/...";
import "solady/...";
import "@uniswap/v2-core/...";
import "@uniswap/v3-core/...";
import "@uniswap/v4-core/...";
import "forge-std/...";
```
