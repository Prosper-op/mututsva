# Mututsva Fuel Station Management System

Mututsva FSMS is a multi-station operations application. One system administrator can manage accounts across stations and switch between station workspaces. Each station has separate operational records, settings, fuel stock, and reports. Staff accounts are assigned to one station.

## Run locally

Install Node.js 22 or newer and run from this project folder:

```powershell
npm start
```

Open http://127.0.0.1:3000. On first launch, create the system administrator using a unique email and a password with at least 12 characters. Add service stations and named staff accounts in Platform access. Station users manage station settings and operations from their assigned station. A new station starts with zero stock; record and approve a delivery before recording sales. A matching pump shift must be open for each sale.

The local database is `data/mututsva.sqlite`. Set `DB_PATH` to choose a different database file. The frontend and API are served from the same origin, so login cookies and station selection use one host.

## Run in a container

Build and run with a persistent volume mounted at `/data`:

```sh
docker build -t mututsva-fsms .
docker run -d --name mututsva -p 3000:3000 -v mututsva-data:/data mututsva-fsms
```

For a cloud container host, configure a durable disk mounted at `/data`, route HTTPS traffic to port 3000, and run one application instance. Do not run multiple app replicas against the same SQLite database. The `/healthz` endpoint is available for host health checks. Keep database files and backups private.

## Included workflows

- Platform administrators can create stations and manage user accounts, but cannot view or change station sales, stock, deliveries, shifts, expenses, reports, audit trails, or database backups. Station teams manage their own operations; station roles are limited to their assigned station.
- Station managers can upload or remove their station's PNG, JPG, or WebP logo (up to 400 KB). It is stored with that station's settings and shown in its signed-in workspace.
- Six server-enforced roles: System Administrator, Station Manager, Supervisor, Cashier, Fuel Attendant, and Accountant.
- First administrator setup, sign-in/sign-out, scrypt password hashes, expiring sessions, and HttpOnly SameSite cookies.
- Fuel products, purchase orders with manager approval, supplier deliveries linked to those orders, physical tank dips, reviewed stock adjustments, and a stock movement ledger.
- POS sales tied to an open pump shift, with saved selling prices and payment methods. Sales, pump meter readings, and collections remain separate records.
- Shift close and manager reconciliation, with variance notes. Sale reversals require manager approval; stock returns only if the reviewer confirms fuel was not dispensed.
- Customer credit accounts with credit limits, balances, repayment records, and validation that prevents credit sales beyond an account's limit.
- Expenses, date-selectable sales reports, CSV exports, user/station/product/supplier configuration, an audit trail, and administrator-only database downloads.

## Operational limits

This is an early release, not a production-certified system. Each station currently models one storage tank per fuel product; it has no employee registry separate from user accounts, configurable pump/nozzle registry, automated dispenser integration, receipt printing, PDF reports, password reset/recovery, or backup restore interface. It does not provide a full double-entry accounting ledger; reconcile sales, collections, expenses, refunds, supplier balances, and profit with the station's accounting procedures. Check role access and operating calculations against real procedures before relying on the system. Production hosting needs HTTPS, restricted database access, monitoring, backup retention, and a rehearsed restore process.
# Railway deployment (free trial)

The repository includes `railway.json` and a Dockerfile-based deployment configuration.

1. Create a Railway project from the `Prosper-op/mututsva` GitHub repository.
2. Deploy the service using the repository's Dockerfile.
3. In the service settings, add a volume mounted at `/data`. The SQLite database is stored at `/data/mututsva.sqlite`; without this volume, database changes can be lost when the container is replaced.
4. Generate a Railway public domain for the service. Railway routes traffic to the app's `PORT` environment variable.
5. Open the public URL and complete the one-time setup to create the first System Administrator. Use a unique strong password and keep it private.

The app automatically sets `HOST=0.0.0.0` and `DB_PATH=/data/mututsva.sqlite` in the Dockerfile. Do not add an administrator password to Railway variables or source control. Back up important records regularly using the in-app administrator backup.

Railway's Free plan has a small monthly usage allowance and sleeps when idle. The first visit after idle can be delayed, and the service can stop after exhausting that allowance. Confirm the current plan limits in Railway before relying on this deployment for live station operations.

