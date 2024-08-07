-- CreateTable
CREATE TABLE "Account" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "App_Info" (
    "id" SERIAL NOT NULL,
    "steam_id" INTEGER NOT NULL,
    "description" TEXT,
    "short_description" TEXT,
    "is_mature" BOOLEAN,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "App_Info_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Apps" (
    "id" SERIAL NOT NULL,
    "steam_id" INTEGER NOT NULL,
    "dlc_steam_id" INTEGER,
    "title" TEXT,
    "type" TEXT NOT NULL,
    "total_reviews" INTEGER,
    "total_positive_reviews" INTEGER,
    "last_modified" INTEGER NOT NULL,
    "price_change_number" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Apps_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Apps_Tags" (
    "steam_id" INTEGER NOT NULL,
    "tag_id" INTEGER NOT NULL,

    CONSTRAINT "Apps_Tags_pkey" PRIMARY KEY ("steam_id","tag_id")
);

-- CreateTable
CREATE TABLE "MostPlayed" (
    "steam_id" INTEGER NOT NULL,
    "app_order" INTEGER NOT NULL,
    "current" INTEGER NOT NULL,
    "peak" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MostPlayed_pkey" PRIMARY KEY ("steam_id")
);

-- CreateTable
CREATE TABLE "Prices" (
    "id" SERIAL NOT NULL,
    "steam_id" INTEGER NOT NULL,
    "is_free" BOOLEAN,
    "currency" TEXT,
    "original_price" INTEGER,
    "discount_price" INTEGER,
    "valid_from" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "valid_to" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Prices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReleaseDate" (
    "id" SERIAL NOT NULL,
    "steam_id" INTEGER NOT NULL,
    "coming_soon" BOOLEAN NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ReleaseDate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Screenshots" (
    "id" SERIAL NOT NULL,
    "steam_id" INTEGER NOT NULL,
    "image_order" INTEGER NOT NULL,
    "path_thumbnail" TEXT NOT NULL,
    "path_full" TEXT NOT NULL,

    CONSTRAINT "Screenshots_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tags" (
    "id" SERIAL NOT NULL,
    "tag_id" INTEGER NOT NULL,
    "tag_name" TEXT NOT NULL,

    CONSTRAINT "Tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TopSellers" (
    "steam_id" INTEGER NOT NULL,
    "app_order" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TopSellers_pkey" PRIMARY KEY ("steam_id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "emailVerified" TIMESTAMP(3),
    "image" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VerificationToken" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "Videos" (
    "id" SERIAL NOT NULL,
    "video_id" INTEGER NOT NULL,
    "steam_id" INTEGER NOT NULL,
    "video_order" INTEGER NOT NULL,

    CONSTRAINT "Videos_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "Account"("provider" ASC, "providerAccountId" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "App_Info_steam_id_key" ON "App_Info"("steam_id" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "Apps_steam_id_key" ON "Apps"("steam_id" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "MostPlayed_steam_id_key" ON "MostPlayed"("steam_id" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "ReleaseDate_steam_id_key" ON "ReleaseDate"("steam_id" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "Screenshots_steam_id_image_order_key" ON "Screenshots"("steam_id" ASC, "image_order" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "Tags_tag_id_key" ON "Tags"("tag_id" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "Tags_tag_name_key" ON "Tags"("tag_name" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "TopSellers_steam_id_key" ON "TopSellers"("steam_id" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_identifier_token_key" ON "VerificationToken"("identifier" ASC, "token" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_token_key" ON "VerificationToken"("token" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "Videos_video_id_key" ON "Videos"("video_id" ASC);

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "App_Info" ADD CONSTRAINT "App_Info_steam_id_fkey" FOREIGN KEY ("steam_id") REFERENCES "Apps"("steam_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apps" ADD CONSTRAINT "Apps_dlc_steam_id_fkey" FOREIGN KEY ("dlc_steam_id") REFERENCES "Apps"("steam_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apps_Tags" ADD CONSTRAINT "Apps_Tags_steam_id_fkey" FOREIGN KEY ("steam_id") REFERENCES "Apps"("steam_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apps_Tags" ADD CONSTRAINT "Apps_Tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "Tags"("tag_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MostPlayed" ADD CONSTRAINT "MostPlayed_steam_id_fkey" FOREIGN KEY ("steam_id") REFERENCES "Apps"("steam_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prices" ADD CONSTRAINT "Prices_steam_id_fkey" FOREIGN KEY ("steam_id") REFERENCES "Apps"("steam_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReleaseDate" ADD CONSTRAINT "ReleaseDate_steam_id_fkey" FOREIGN KEY ("steam_id") REFERENCES "Apps"("steam_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Screenshots" ADD CONSTRAINT "Screenshots_steam_id_fkey" FOREIGN KEY ("steam_id") REFERENCES "Apps"("steam_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TopSellers" ADD CONSTRAINT "TopSellers_steam_id_fkey" FOREIGN KEY ("steam_id") REFERENCES "Apps"("steam_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Videos" ADD CONSTRAINT "Videos_steam_id_fkey" FOREIGN KEY ("steam_id") REFERENCES "Apps"("steam_id") ON DELETE CASCADE ON UPDATE CASCADE;

