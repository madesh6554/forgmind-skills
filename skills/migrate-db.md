---
name: migrate-db
description: Apply Supabase SQL migrations from supabase/ to the running supabase-db Docker container. Use when the user says "run migrations", "apply the schema", or after adding/editing files under supabase/00NN_*.sql.
---

# Apply Supabase migrations

The project ships migrations as plain SQL in `supabase/` with a strict `00NN_<name>.sql` naming convention. They're applied by `scripts/migrate.sh` which is wired up as `npm run migrate`.

## Steps

1. Confirm with the user before running — migrations mutate the live DB. Show them which files will be applied:
   ```bash
   ls supabase/[0-9][0-9][0-9][0-9]_*.sql
   ```
2. Run the migration script:
   ```bash
   npm run migrate
   ```
3. If you changed which schemas are exposed (rare), reload PostgREST:
   ```bash
   docker compose -f /root/docker-compose.yml up -d --force-recreate rest
   ```

## Notes

- Files run in **lexical order** — never reuse a number, never insert one in the middle. New migration → next free `00NN_*.sql`.
- `seed_*.sql` files are intentionally **skipped** by `migrate.sh`. Run them by hand:
  ```bash
  docker cp supabase/seed_sample.sql supabase-db:/tmp/seed.sql
  docker exec supabase-db psql -U postgres -d postgres -f /tmp/seed.sql
  ```
- All app tables live in the `serene_paathshala_sales_log` schema, exposed via `PGRST_DB_SCHEMAS=…,serene_paathshala_sales_log` in `/root/.env`. Adding a table to a different schema means it won't be reachable from supabase-js without that env var change.
- After the migration, smoke-test:
  ```bash
  npm run test:sql
  ```
