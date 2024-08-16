-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "shop" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "isOnline" BOOLEAN NOT NULL DEFAULT false,
    "scope" TEXT,
    "expires" DATETIME,
    "accessToken" TEXT NOT NULL,
    "userId" BIGINT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "shopify_tdc_configurationshopify" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "sessionId" TEXT NOT NULL,
    "shop" TEXT NOT NULL,
    "ready" BOOLEAN NOT NULL DEFAULT true,
    "apiVersion" TEXT NOT NULL DEFAULT 'unstable',
    "pCustId" TEXT NOT NULL,
    "pKey" TEXT NOT NULL,
    "privateKey" TEXT NOT NULL,
    "publicKey" TEXT NOT NULL,
    "lenguage" TEXT NOT NULL,
    CONSTRAINT "shopify_tdc_configurationshopify_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES "Session" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "shopify_tdc_paymentsession" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "gid" TEXT NOT NULL,
    "group" TEXT NOT NULL,
    "amount" DECIMAL NOT NULL,
    "test" BOOLEAN NOT NULL,
    "currency" TEXT NOT NULL,
    "kind" TEXT NOT NULL,
    "shop" TEXT NOT NULL,
    "paymentMethod" TEXT NOT NULL,
    "customer" TEXT NOT NULL,
    "proposedAt" DATETIME NOT NULL,
    "status" TEXT,
    "clientDetails" TEXT,
    "threeDSecureAuthentication" TEXT
);

-- CreateTable
CREATE TABLE "shopify_tdc_refundsession" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "gid" TEXT NOT NULL,
    "paymentId" TEXT NOT NULL,
    "amount" DECIMAL NOT NULL,
    "currency" TEXT NOT NULL,
    "proposedAt" DATETIME NOT NULL,
    "status" TEXT,
    CONSTRAINT "shopify_tdc_refundsession_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "shopify_tdc_paymentsession" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "shopify_tdc_capturesession" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "gid" TEXT NOT NULL,
    "paymentId" TEXT NOT NULL,
    "amount" DECIMAL NOT NULL,
    "currency" TEXT NOT NULL,
    "proposedAt" DATETIME NOT NULL,
    "status" TEXT,
    CONSTRAINT "shopify_tdc_capturesession_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "shopify_tdc_paymentsession" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "shopify_tdc_voidsession" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "gid" TEXT NOT NULL,
    "paymentId" TEXT NOT NULL,
    "proposedAt" DATETIME NOT NULL,
    "status" TEXT,
    CONSTRAINT "shopify_tdc_voidsession_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "shopify_tdc_paymentsession" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "shopify_tdc_configurationshopify_sessionId_key" ON "shopify_tdc_configurationshopify"("sessionId");

-- CreateIndex
CREATE INDEX "shopify_tdc_configurationshopify_sessionId_idx" ON "shopify_tdc_configurationshopify"("sessionId");

-- CreateIndex
CREATE INDEX "shopify_tdc_refundsession_paymentId_fkey" ON "shopify_tdc_refundsession"("paymentId");

-- CreateIndex
CREATE INDEX "shopify_tdc_capturesession_paymentId_fkey" ON "shopify_tdc_capturesession"("paymentId");

-- CreateIndex
CREATE UNIQUE INDEX "shopify_tdc_voidsession_paymentId_key" ON "shopify_tdc_voidsession"("paymentId");
