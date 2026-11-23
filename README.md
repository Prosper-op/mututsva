# Mututsva Fuel Station Management System

Mututsva FSMS is a single-station operations application based on the supplied workflow specification. It runs on Node.js and stores shared records in SQLite, so staff use separate accounts against the same station data.

## Start the application

Install Node.js 22 or newer and run from this project folder:

```powershell
npm start
```

Open http://127.0.0.1:3000. On first launch, create the system administrator using a unique email and a password with at least 12 characters. Add named staff accounts in Station settings. Configure station details, products, prices, capacities, and suppliers. Stock starts at zero: record and approve a delivery before recording sales. A matching pump shift must be open for each sale.

The server binds to localhost by default. For multiple workstations on a protected local network, set `HOST=0.0.0.0` and `NODE_ENV=production` in the server environment and place it behind an HTTPS reverse proxy with firewall controls. Do not expose the Node server directly to the public internet.

## Included workflows

- Six server-enforced roles: System Administrator, Station Manager, Supervisor, Cashier, Fuel Attendant, and Accountant. Accounts are separate and all authorized staff share the same database.
- First administrator setup, sign-in/sign-out, scrypt password hashes, expiring sessions, and HttpOnly SameSite cookies.
- Fuel products, purchase orders with manager approval, supplier deliveries linked to those orders, independent physical tank dips, reviewed stock adjustments, and a stock movement ledger with before/after balances.
- POS sales tied to an open pump shift, with saved selling prices and payment methods. Sales, pump meter readings, and collections remain separate records.
- Shift close and manager reconciliation, with variance notes. Sale reversals remain in history and require manager approval; stock returns only if the reviewer confirms fuel was not dispensed.
- Customer credit accounts with credit limits, balances, repayment records, and validation that prevents credit sales beyond an account's limit.
- Expenses, date-selectable daily sales reports, CSV exports, user/station/product/supplier configuration, and an audit trail.
- Administrator-only SQLite snapshot downloads from Station settings. Store downloaded backups securely and verify your recovery process routinely.

## Deployment and operational limits

This is a local first release, not a production deployment. It covers one station and currently models one storage tank per fuel product; it has no employee registry separate from user accounts, configurable pump/nozzle registry, automated dispenser integration, receipt printing, PDF reports, password reset/recovery, or backup restore interface. The application does not yet provide a full double-entry accounting ledger; sales, collections, expenses, refunds, supplier balances, and profit must be reconciled with the station's accounting procedures. Check role access and operating calculations against real procedures before operational reliance. Production hosting needs HTTPS, controlled database access, monitoring, backup retention, and a rehearsed restore process.

Built from the supplied Mututsva FSMS System Workflow document.
