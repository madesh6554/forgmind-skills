---
name: n8n-push
description: Push an exported n8n workflow JSON to the self-hosted n8n at n8n.srv1615879.hstgr.cloud and (re)activate it. Use when the user says "push the workflow", "deploy n8n", or after editing files in n8n-workflows/.
---

# Push an n8n workflow

n8n is the **submission gateway** for the Flutter app — every counselor entry flows through it (OCR → Drive → Supabase). Pushing a broken workflow breaks all submissions, so be deliberate.

## Workflows in this repo

| Workflow | File | Workflow ID | Trigger |
|---|---|---|---|
| Serene Paathshala — Counselor Submit | `n8n-workflows/sp-sales-submit.json` | `OTrypxoRX9h1FtMl` | Webhook POST `/sp-sales-submit` |
| Serene Paathshala — Weekly Batch Folder | `n8n-workflows/sp-batch-folder.json` | `VgykgXJ0Ej5rkPcF` | Cron: Friday 9am IST |

The submission webhook URL the frontend / Flutter app point at is `https://n8n.srv1615879.hstgr.cloud/webhook/sp-sales-submit` (set in `frontend/.env.local` and the project `docker-compose.yml` build args).

## Steps

1. **Edit in the n8n UI first** (https://n8n.srv1615879.hstgr.cloud) — that's the source of truth. Then export the JSON via Workflow → ⋮ → "Download".
2. Save it into `n8n-workflows/<name>.json` (use the new sp-sales naming on this server).
3. Confirm with the user before pushing — this is production.
4. Push and activate:
   ```bash
   API_KEY="$N8N_API_KEY"
   ID=<workflow id from the new n8n>
   FILE=n8n-workflows/sp-sales-submit.json

   curl -fsSL -X PUT "https://n8n.srv1615879.hstgr.cloud/api/v1/workflows/$ID" \
     -H "X-N8N-API-KEY: $API_KEY" \
     -H "Content-Type: application/json" \
     -d "@$FILE"

   curl -fsSL -X POST "https://n8n.srv1615879.hstgr.cloud/api/v1/workflows/$ID/activate" \
     -H "X-N8N-API-KEY: $API_KEY"
   ```
5. Verify by submitting a test entry from the Flutter app (or `curl`-ing the webhook with a small fixture) and checking the n8n execution log.

## Gotchas

- `sp-sales-submit.json`'s "Upload to Supabase Storage" node has the value `Bearer SUPABASE_SERVICE_ROLE_KEY_PLACEHOLDER` instead of the real key — that JWT was deliberately redacted before the file was committed. **Before pushing this JSON, swap the placeholder back to the current `SERVICE_ROLE_KEY` from `/root/.env`** or the storage uploads will return 401. The running n8n already has the real key; this is only a concern when re-pushing the on-disk JSON.
- The exported JSON contains node credentials by **reference** (UUIDs), not values. If you import on a fresh n8n instance, you need to recreate the credentials and rewire each node — don't try to edit credentials in the JSON by hand.
- The webhook URL is **production** (`/webhook/sp-sales-submit`) once activated. If you want to test without breaking real submissions, duplicate the workflow in n8n with `/webhook-test/...` and only push when verified.
- Duplicate transaction IDs are caught by the `transaction_id_lookup` UNIQUE constraint — any "duplicate" path in the workflow assumes that constraint exists. If you removed it in a migration, the workflow will start inserting dupes.
- If a push goes wrong, the n8n UI has a version history per workflow — roll back from there rather than re-pushing an older JSON.
