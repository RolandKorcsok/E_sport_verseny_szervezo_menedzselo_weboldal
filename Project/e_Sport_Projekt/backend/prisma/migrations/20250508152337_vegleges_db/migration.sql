-- CreateTable
CREATE TABLE `Users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `inviteable` BOOLEAN NOT NULL,
    `full_name` VARCHAR(64) NOT NULL,
    `usr_name` VARCHAR(16) NOT NULL,
    `usna_last_mod_date` DATETIME(3) NOT NULL,
    `usna_mod_num_remain` INTEGER NOT NULL,
    `paswrd` VARCHAR(60) NOT NULL,
    `date_of_birth` DATE NOT NULL,
    `school` VARCHAR(100) NOT NULL,
    `clss` VARCHAR(10) NOT NULL,
    `email_address` VARCHAR(64) NOT NULL,
    `email_last_mod_date` DATETIME(3) NOT NULL,
    `phone_num` VARCHAR(15) NOT NULL,
    `om_identifier` VARCHAR(11) NOT NULL,
    `status` VARCHAR(12) NOT NULL,
    `discord_name` VARCHAR(32) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Organizers` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `full_name` VARCHAR(64) NOT NULL,
    `usr_name` VARCHAR(16) NOT NULL,
    `usna_last_mod_date` DATETIME(3) NOT NULL,
    `usna_mod_num_remain` INTEGER NOT NULL,
    `paswrd` VARCHAR(60) NOT NULL,
    `date_of_birth` DATE NOT NULL,
    `school` VARCHAR(100) NOT NULL,
    `email_address` VARCHAR(64) NOT NULL,
    `email_last_mod_date` DATETIME(3) NOT NULL,
    `phone_num` VARCHAR(15) NOT NULL,
    `om_identifier` VARCHAR(11) NOT NULL,
    `status` VARCHAR(12) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Teams` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `short_name` VARCHAR(4) NOT NULL,
    `full_name` VARCHAR(16) NOT NULL,
    `creator_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Events` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `start_date` DATETIME(3) NOT NULL,
    `end_date` DATETIME(3) NOT NULL,
    `place` VARCHAR(255) NOT NULL,
    `details` VARCHAR(512) NULL,
    `ogr_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Games` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Tournaments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `num_participant` INTEGER NOT NULL,
    `team_num` INTEGER NOT NULL,
    `start_date` DATETIME(3) NOT NULL,
    `end_date` DATETIME(3) NOT NULL,
    `game_mode` VARCHAR(32) NOT NULL,
    `max_participant` INTEGER NOT NULL,
    `apn_start` DATETIME(3) NOT NULL,
    `apn_end` DATETIME(3) NOT NULL,
    `details` VARCHAR(512) NULL,
    `evt_id` INTEGER NOT NULL,
    `gae_id` INTEGER NOT NULL,

    UNIQUE INDEX `Tournaments_id_key`(`id`),
    PRIMARY KEY (`id`, `evt_id`, `gae_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Pictures` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `img_path` VARCHAR(16384) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Team_Memberships` (
    `status` VARCHAR(12) NOT NULL,
    `uer_id` INTEGER NOT NULL,
    `tem_id` INTEGER NOT NULL,

    PRIMARY KEY (`uer_id`, `tem_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Matches` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `status` VARCHAR(12) NOT NULL,
    `place` VARCHAR(255) NULL,
    `dte` DATETIME(3) NULL,
    `details` VARCHAR(512) NULL,
    `winner` VARCHAR(16) NULL,
    `rslt` VARCHAR(10) NULL,
    `apn1_id` INTEGER NOT NULL,
    `apn2_id` INTEGER NOT NULL,
    `tnt_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`, `apn1_id`, `apn2_id`, `tnt_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Applications` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `dte` DATETIME(3) NOT NULL,
    `status` VARCHAR(12) NOT NULL,
    `uer1_id` INTEGER NULL,
    `uer2_id` INTEGER NULL,
    `uer3_id` INTEGER NULL,
    `uer4_id` INTEGER NULL,
    `uer5_id` INTEGER NULL,
    `tem_id` INTEGER NULL,
    `tnt_id` INTEGER NOT NULL,

    UNIQUE INDEX `Applications_id_key`(`id`),
    UNIQUE INDEX `Applications_uer1_id_uer2_id_uer3_id_uer4_id_uer5_id_tem_id__key`(`uer1_id`, `uer2_id`, `uer3_id`, `uer4_id`, `uer5_id`, `tem_id`, `tnt_id`),
    PRIMARY KEY (`id`, `tnt_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Picture_Links` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `uer_id` INTEGER NULL,
    `tem_id` INTEGER NULL,
    `tnt_id` INTEGER NULL,
    `evt_id` INTEGER NULL,
    `ogr_id` INTEGER NULL,
    `pte_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`, `pte_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Events` ADD CONSTRAINT `Events_ogr_id_fkey` FOREIGN KEY (`ogr_id`) REFERENCES `Organizers`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Tournaments` ADD CONSTRAINT `Tournaments_evt_id_fkey` FOREIGN KEY (`evt_id`) REFERENCES `Events`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Tournaments` ADD CONSTRAINT `Tournaments_gae_id_fkey` FOREIGN KEY (`gae_id`) REFERENCES `Games`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Team_Memberships` ADD CONSTRAINT `Team_Memberships_uer_id_fkey` FOREIGN KEY (`uer_id`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Team_Memberships` ADD CONSTRAINT `Team_Memberships_tem_id_fkey` FOREIGN KEY (`tem_id`) REFERENCES `Teams`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Matches` ADD CONSTRAINT `Matches_apn1_id_fkey` FOREIGN KEY (`apn1_id`) REFERENCES `Applications`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Matches` ADD CONSTRAINT `Matches_apn2_id_fkey` FOREIGN KEY (`apn2_id`) REFERENCES `Applications`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Matches` ADD CONSTRAINT `Matches_tnt_id_fkey` FOREIGN KEY (`tnt_id`) REFERENCES `Tournaments`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Applications` ADD CONSTRAINT `Applications_uer1_id_fkey` FOREIGN KEY (`uer1_id`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Applications` ADD CONSTRAINT `Applications_uer2_id_fkey` FOREIGN KEY (`uer2_id`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Applications` ADD CONSTRAINT `Applications_uer3_id_fkey` FOREIGN KEY (`uer3_id`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Applications` ADD CONSTRAINT `Applications_uer4_id_fkey` FOREIGN KEY (`uer4_id`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Applications` ADD CONSTRAINT `Applications_uer5_id_fkey` FOREIGN KEY (`uer5_id`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Applications` ADD CONSTRAINT `Applications_tem_id_fkey` FOREIGN KEY (`tem_id`) REFERENCES `Teams`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Applications` ADD CONSTRAINT `Applications_tnt_id_fkey` FOREIGN KEY (`tnt_id`) REFERENCES `Tournaments`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Picture_Links` ADD CONSTRAINT `Picture_Links_uer_id_fkey` FOREIGN KEY (`uer_id`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Picture_Links` ADD CONSTRAINT `Picture_Links_tem_id_fkey` FOREIGN KEY (`tem_id`) REFERENCES `Teams`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Picture_Links` ADD CONSTRAINT `Picture_Links_tnt_id_fkey` FOREIGN KEY (`tnt_id`) REFERENCES `Tournaments`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Picture_Links` ADD CONSTRAINT `Picture_Links_evt_id_fkey` FOREIGN KEY (`evt_id`) REFERENCES `Events`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Picture_Links` ADD CONSTRAINT `Picture_Links_ogr_id_fkey` FOREIGN KEY (`ogr_id`) REFERENCES `Organizers`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Picture_Links` ADD CONSTRAINT `Picture_Links_pte_id_fkey` FOREIGN KEY (`pte_id`) REFERENCES `Pictures`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
