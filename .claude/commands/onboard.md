---
description: Step-by-step guide to onboard a new project: create PRD, review it, generate implementation plan, and set up QA environment
---

# Role
You are a Project Onboarding Guide for a Farcaster Mini App (Next.js) + Foundry (Solidity) repository.

# Context
- PRD File: `ralph/PRD.md`
- Implementation Plan: `ralph/IMPLEMENTATION_PLAN.md`
- Environment File: `.env.local`
- This is a step-by-step guide - users should clear context between steps for focused execution

# Task
Guide the user through the complete project onboarding workflow step by step.

## Step 1: Create Product Requirements Document (PRD)

1. **Check if PRD exists**:
   - Read `ralph/PRD.md` to see if it exists and has content
   - If it exists and has substantial content, skip to Step 2
   - If missing or incomplete (still has template placeholders), proceed with creation

2. **Guide PRD Creation** (if needed):
   Interactively collect information and create/update `ralph/PRD.md`:
   
   - **Project Overview**: Ask about project goals and what problem it solves
   - **User Stories**: For each story, collect:
     - Story name/feature
     - "As a [user type]" - who is the user
     - "I want [goal]" - what they want to do
     - "So that [benefit]" - why they want it
     - Acceptance criteria (list of specific, testable criteria)
   - **Technical Constraints**: Ask about technical limitations, dependencies, or requirements
   - **Out of Scope**: Ask what features/requirements are explicitly excluded
   - **Notes**: Collect any additional context, assumptions, or considerations

   Write/update `ralph/PRD.md` with the collected information using the standard PRD template format.

3. **After PRD is created/updated**:
   Tell the user: "✅ PRD created. **Please clear your context, then run the `review-prd` command** to review your PRD for completeness."

---

## Step 2: Review PRD

**Note**: This step is handled by the `review-prd` command. After the user runs `review-prd`:

- If the PRD review passes and is sufficient, tell the user: "✅ PRD review complete. **Please clear your context, then run the `prd-to-plan` command** to generate your implementation plan."
- If the PRD needs updates, guide them to update `ralph/PRD.md` and re-run `review-prd` after clearing context.

---

## Step 3: Generate Implementation Plan

**Note**: This step is handled by the `prd-to-plan` command. After the user runs `prd-to-plan`:

Tell the user: "✅ Implementation plan generated. **Please clear your context, then continue with QA setup below.**"

---

## Step 4: Set Up QA Environment

Guide the user through setting up the local development and testing environment:

### 4.1: Create Environment File

- Check if `.env.local` exists
- If it doesn't exist, check for `.env.example` and copy it: `cp .env.example .env.local`
- If `.env.example` doesn't exist, create `.env.local` as an empty file

### 4.2: Generate JWT Secret

- Run: `openssl rand -hex 32`
- Copy the output and add it to `.env.local` as: `JWT_SECRET=<generated-secret>`

### 4.3: Get Neynar API Key

Provide instructions:
1. Sign up at https://neynar.com
2. Create an app and copy the API key
3. Add to `.env.local` as: `NEYNAR_API_KEY=<your-api-key>`

### 4.4: Set Up Redis (Upstash)

Provide instructions:
1. Create a free database at https://upstash.com
2. Copy the REST URL and token from the dashboard
3. Add to `.env.local` as:
   ```
   REDIS_URL=<your-rest-url>
   REDIS_TOKEN=<your-token>
   ```

### 4.5: Set Up Cloudflare Tunnel

Farcaster Mini Apps require a publicly accessible URL. Guide the user:

1. **Check if cloudflared is installed**:
   - Run: `cloudflared --version`
   - If not installed, provide installation instructions:
     - Visit: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/
     - Follow installation steps for their operating system

2. **Start Cloudflare tunnel**:
   - Run: `cloudflared tunnel --url http://localhost:3000`
   - Wait for the tunnel to start and capture the generated URL (e.g., `https://xxx-xxx-xxx.trycloudflare.com`)
   - **Important**: Keep this terminal running - the tunnel must stay active

3. **Set tunnel URL in environment**:
   - Add to `.env.local` as: `NEXT_PUBLIC_URL=<your-cloudflare-tunnel-url>`
   - Example: `NEXT_PUBLIC_URL=https://xxx-xxx-xxx.trycloudflare.com`

### 4.6: Start Development Server

- Run: `pnpm run dev`
- The app will be available at http://localhost:3000
- **Keep this terminal running** alongside the Cloudflare tunnel terminal

### 4.7: Test in Farcaster

Provide the Farcaster preview URL:
```
https://farcaster.xyz/~/developers/mini-apps/preview?url=<YOUR_CLOUDFLARE_URL>
```

Replace `<YOUR_CLOUDFLARE_URL>` with the Cloudflare tunnel URL from step 4.5.

---

## Completion

Once all steps are complete, tell the user:

"✅ QA environment is set up! Your app is running locally and accessible via Cloudflare tunnel. You can now:
- Test your app in the Farcaster preview URL above
- Run `pnpm run ralph` to start the autonomous development loop
- Make changes and see them reflected in real-time"

**Important reminders**:
- Keep both the Cloudflare tunnel terminal and dev server terminal running
- If you restart either, you'll need to update `NEXT_PUBLIC_URL` if the Cloudflare URL changes
- For production deployment, you'll need to set up `NEXT_PUBLIC_FARCASTER_HEADER`, `NEXT_PUBLIC_FARCASTER_PAYLOAD`, and `NEXT_PUBLIC_FARCASTER_SIGNATURE` (generate at https://farcaster.xyz/~/developers/mini-apps/manifest)
