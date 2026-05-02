---
name: deploy-frontend
description: Rebuild and redeploy the React web admin (sp-sales-frontend Docker container) to https://sp-sales-log.srv1615879.hstgr.cloud. Use when the user says "deploy the frontend", "ship the admin", or after editing files under frontend/.
---

# Deploy the React web admin

The web admin runs as a Docker container `sp-sales-frontend`, defined in `/root/docker-compose.yml`, fronted by Traefik with the `mytlschallenge` cert resolver.

## Steps

1. Confirm with the user — this is a production deploy.
2. Make sure the build will pick up the right env. The Dockerfile reads `VITE_SUPABASE_*` from build args sourced from `/root/.env`. If those changed, `docker compose build` is enough — no separate step.
3. Run:
   ```bash
   npm run deploy
   ```
   That script runs `docker compose build sp-sales-frontend && docker compose up -d --force-recreate sp-sales-frontend`, then prints container status and a `curl -sI` health check.
4. Verify by visiting https://sp-sales-log.srv1615879.hstgr.cloud and checking the version footer / hard-refreshing in a logged-in session.
5. If something looks off:
   ```bash
   npm run logs                # tails sp-sales-frontend
   ```

## Gotchas

- **Don't** edit Traefik labels for the cert resolver; the right value is `mytlschallenge`, not `letsencrypt`.
- The `ANON_KEY` baked into the bundle is public — no security concern. The `SERVICE_ROLE_KEY` must never appear in `frontend/`.
- Hard refresh after deploy — TanStack Query and the SPA shell can serve stale JS otherwise.
- If the container won't start, the most common cause is a missing/misnamed env var in `/root/.env` (look at `docker logs sp-sales-frontend` for the build-time message).
