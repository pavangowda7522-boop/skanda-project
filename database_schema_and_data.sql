-- ==========================================================================
-- CatchIt: Smart Bus Schedule & Transportation Management System
-- Complete Database Schema and Seed Data Export (ANSI SQL / MySQL / SQLite)
-- ==========================================================================

BEGIN TRANSACTION;
CREATE TABLE bookings (
        booking_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        schedule_id INTEGER NOT NULL,
        passenger_name TEXT NOT NULL,
        seat_number TEXT NOT NULL,
        travel_date TEXT NOT NULL,
        fare_paid REAL NOT NULL DEFAULT 120.0,
        booking_code TEXT UNIQUE NOT NULL,
        status TEXT NOT NULL DEFAULT 'Confirmed' CHECK(status IN ('Confirmed', 'Boarded', 'Cancelled', 'Completed')),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id)
    );
INSERT INTO "bookings" VALUES(1,3,1,'Skanda Bharadwaj','1A','2026-09-19',140.0,'CI-2026-TKBLR-01','Confirmed','2026-09-19 12:20:39');
INSERT INTO "bookings" VALUES(2,3,3,'Skanda Bharadwaj','2D','2026-09-19',95.0,'CI-2026-TKDBP-02','Confirmed','2026-09-19 12:20:39');
INSERT INTO "bookings" VALUES(3,3,1,'Skanda Bharadwaj','1D','2026-09-18',140.0,'CI-2026-TKBLR-99','Boarded','2026-09-19 12:20:39');
INSERT INTO "bookings" VALUES(4,3,5,'Skanda Bharadwaj','3A','2026-09-14',220.0,'CI-2026-TKMYS-44','Completed','2026-09-19 12:20:39');
INSERT INTO "bookings" VALUES(5,20,1,'Ananya Sharma','2A','2026-09-19',140.0,'CI-2026-TKBLR-03','Confirmed','2026-09-19 12:20:39');
INSERT INTO "bookings" VALUES(6,21,2,'Karthik Varma','4B','2026-09-19',85.0,'CI-2026-TKNGS-04','Confirmed','2026-09-19 12:20:39');
CREATE TABLE buses (
        bus_id INTEGER PRIMARY KEY AUTOINCREMENT,
        bus_number TEXT UNIQUE NOT NULL,
        bus_type TEXT NOT NULL,
        capacity INTEGER NOT NULL,
        status TEXT NOT NULL DEFAULT 'Active' CHECK(status IN ('Active', 'Maintenance', 'Out of Service'))
    );
INSERT INTO "buses" VALUES(1,'KA01AB1234','AC Sleeper',40,'Active');
INSERT INTO "buses" VALUES(2,'KA05CD5678','Non-AC',45,'Active');
INSERT INTO "buses" VALUES(3,'KA09EF9012','Non-AC',45,'Active');
INSERT INTO "buses" VALUES(4,'KA11GH3456','Volvo',50,'Maintenance');
INSERT INTO "buses" VALUES(5,'KA13IJ7890','AC',42,'Active');
INSERT INTO "buses" VALUES(6,'KA04KL2345','Volvo Multi-Axle',48,'Active');
INSERT INTO "buses" VALUES(7,'KA06MN6789','AC Sleeper',36,'Active');
INSERT INTO "buses" VALUES(8,'KA02OP1122','Non-AC Deluxe',52,'Active');
INSERT INTO "buses" VALUES(9,'KA03QR3344','Electric AC',45,'Active');
INSERT INTO "buses" VALUES(10,'KA07ST5566','Volvo',50,'Active');
INSERT INTO "buses" VALUES(11,'KA08UV7788','AC Seater',44,'Active');
INSERT INTO "buses" VALUES(12,'KA10WX9900','Non-AC',55,'Active');
INSERT INTO "buses" VALUES(13,'KA12YZ1234','AC Sleeper',40,'Active');
INSERT INTO "buses" VALUES(14,'KA14AA5678','Volvo',52,'Active');
INSERT INTO "buses" VALUES(15,'KA15BB9012','Electric AC',46,'Active');
INSERT INTO "buses" VALUES(16,'KA16CC3456','Non-AC Deluxe',50,'Active');
INSERT INTO "buses" VALUES(17,'KA17DD7890','AC Sleeper',38,'Active');
INSERT INTO "buses" VALUES(18,'KA18EE2345','Volvo Multi-Axle',48,'Active');
INSERT INTO "buses" VALUES(19,'KA19FF6789','AC Seater',42,'Active');
INSERT INTO "buses" VALUES(20,'KA20GG1122','Non-AC',54,'Active');
INSERT INTO "buses" VALUES(21,'KA21HH3344','Volvo',50,'Active');
INSERT INTO "buses" VALUES(22,'KA22II5566','Electric AC',45,'Active');
INSERT INTO "buses" VALUES(23,'KA23JJ7788','AC Sleeper',40,'Active');
INSERT INTO "buses" VALUES(24,'KA24KK9900','Non-AC',52,'Active');
INSERT INTO "buses" VALUES(25,'KA25LL1234','Volvo',50,'Active');
CREATE TABLE delays (
        delay_id INTEGER PRIMARY KEY AUTOINCREMENT,
        schedule_id INTEGER NOT NULL,
        delay_minutes INTEGER NOT NULL,
        reason TEXT NOT NULL,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id) ON DELETE CASCADE
    );
INSERT INTO "delays" VALUES(1,2,15,'Heavy traffic near Dabaspet toll','2026-09-19 12:20:39');
INSERT INTO "delays" VALUES(2,8,20,'Rain & slow moving traffic on NH48','2026-09-19 12:20:39');
INSERT INTO "delays" VALUES(3,12,10,'Signal delay at Yeshwanthpur flyover','2026-09-19 12:20:39');
INSERT INTO "delays" VALUES(4,27,25,'Bridge maintenance diversion near Nelamangala','2026-09-19 12:20:39');
CREATE TABLE driver_shifts (
        shift_id INTEGER PRIMARY KEY AUTOINCREMENT,
        driver_id INTEGER NOT NULL,
        shift_date TEXT NOT NULL,
        start_time TEXT NOT NULL,
        end_time TEXT,
        hours_worked REAL NOT NULL DEFAULT 0.0,
        status TEXT NOT NULL DEFAULT 'Active' CHECK(status IN ('Active', 'Completed')),
        FOREIGN KEY (driver_id) REFERENCES users(id)
    );
INSERT INTO "driver_shifts" VALUES(1,2,'2026-09-19','06:00',NULL,6.5,'Active');
INSERT INTO "driver_shifts" VALUES(2,2,'2026-09-18','06:30','14:30',8.0,'Completed');
INSERT INTO "driver_shifts" VALUES(3,2,'2026-09-17','07:00','15:30',8.5,'Completed');
INSERT INTO "driver_shifts" VALUES(4,2,'2026-09-16','06:00','14:00',8.0,'Completed');
INSERT INTO "driver_shifts" VALUES(5,2,'2026-09-15','07:30','14:30',7.0,'Completed');
INSERT INTO "driver_shifts" VALUES(6,4,'2026-09-19','07:00',NULL,5.5,'Active');
INSERT INTO "driver_shifts" VALUES(7,5,'2026-09-19','08:00',NULL,4.5,'Active');
CREATE TABLE routes (
        route_id INTEGER PRIMARY KEY AUTOINCREMENT,
        route_name TEXT NOT NULL,
        source TEXT NOT NULL,
        destination TEXT NOT NULL,
        distance_km INTEGER NOT NULL,
        base_fare REAL NOT NULL DEFAULT 80.0
    );
INSERT INTO "routes" VALUES(1,'Tumkur - Bangalore','Tumkur','Bangalore',70,120.0);
INSERT INTO "routes" VALUES(2,'Tumkur - Nagasandra','Tumkur','Nagasandra',45,80.0);
INSERT INTO "routes" VALUES(3,'Tumkur - Doddaballapur','Tumkur','Doddaballapur',60,95.0);
INSERT INTO "routes" VALUES(4,'Tumkur - Nelamangala','Tumkur','Nelamangala',35,60.0);
INSERT INTO "routes" VALUES(5,'Tumkur - Mysore','Tumkur','Mysore',150,220.0);
INSERT INTO "routes" VALUES(6,'Bangalore - Tumkur','Bangalore','Tumkur',70,120.0);
INSERT INTO "routes" VALUES(7,'Bangalore - Mysore','Bangalore','Mysore',145,210.0);
INSERT INTO "routes" VALUES(8,'Tumkur - Sira','Tumkur','Sira',55,85.0);
INSERT INTO "routes" VALUES(9,'Tumkur - Gubbi','Tumkur','Gubbi',22,40.0);
INSERT INTO "routes" VALUES(10,'Tumkur - Hassan','Tumkur','Hassan',128,190.0);
INSERT INTO "routes" VALUES(11,'Bangalore - Doddaballapur','Bangalore','Doddaballapur',40,70.0);
INSERT INTO "routes" VALUES(12,'Tumkur - Tiptur','Tumkur','Tiptur',74,110.0);
CREATE TABLE schedules (
        schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
        bus_id INTEGER NOT NULL,
        route_id INTEGER NOT NULL,
        driver_id INTEGER,
        departure_time TEXT NOT NULL,
        arrival_time TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'On Time' CHECK(status IN ('On Time', 'Delayed', 'Cancelled', 'Not Started')),
        occupancy TEXT NOT NULL DEFAULT 'Low' CHECK(occupancy IN ('Low', 'Medium', 'High', 'Full')),
        delay_minutes INTEGER NOT NULL DEFAULT 0,
        delay_reason TEXT,
        fare REAL NOT NULL DEFAULT 120.0,
        FOREIGN KEY (bus_id) REFERENCES buses(bus_id),
        FOREIGN KEY (route_id) REFERENCES routes(route_id),
        FOREIGN KEY (driver_id) REFERENCES users(id)
    );
INSERT INTO "schedules" VALUES(1,1,1,2,'08:00','10:00','On Time','High',0,NULL,140.0);
INSERT INTO "schedules" VALUES(2,2,2,4,'09:15','10:20','Delayed','Medium',15,'Heavy traffic near Dabaspet toll',85.0);
INSERT INTO "schedules" VALUES(3,3,3,5,'10:30','11:45','On Time','Low',0,NULL,95.0);
INSERT INTO "schedules" VALUES(4,4,4,6,'11:45','12:35','Cancelled','Low',0,'Technical maintenance',60.0);
INSERT INTO "schedules" VALUES(5,5,5,7,'07:30','10:40','On Time','High',0,NULL,220.0);
INSERT INTO "schedules" VALUES(6,1,1,2,'12:30','14:30','Not Started','Low',0,NULL,140.0);
INSERT INTO "schedules" VALUES(7,6,6,8,'08:30','10:30','On Time','Full',0,NULL,160.0);
INSERT INTO "schedules" VALUES(8,7,2,9,'09:45','10:50','On Time','Medium',0,NULL,85.0);
INSERT INTO "schedules" VALUES(9,8,3,10,'11:15','12:30','Delayed','High',20,'Rain & slow moving traffic',95.0);
INSERT INTO "schedules" VALUES(10,9,4,11,'13:00','13:50','On Time','Low',0,NULL,60.0);
INSERT INTO "schedules" VALUES(11,10,5,12,'14:00','17:10','On Time','Medium',0,NULL,220.0);
INSERT INTO "schedules" VALUES(12,11,1,13,'15:30','17:30','On Time','Full',0,NULL,140.0);
INSERT INTO "schedules" VALUES(13,12,6,14,'16:15','18:15','Delayed','Medium',10,'Signal delay at Yeshwanthpur',160.0);
INSERT INTO "schedules" VALUES(14,13,2,15,'17:00','18:05','On Time','High',0,NULL,85.0);
INSERT INTO "schedules" VALUES(15,14,3,16,'18:00','19:15','On Time','Medium',0,NULL,95.0);
INSERT INTO "schedules" VALUES(16,15,7,17,'06:00','08:00','On Time','High',0,NULL,150.0);
INSERT INTO "schedules" VALUES(17,16,1,18,'06:45','08:45','On Time','Low',0,NULL,140.0);
INSERT INTO "schedules" VALUES(18,17,2,19,'07:15','08:20','On Time','Medium',0,NULL,85.0);
INSERT INTO "schedules" VALUES(19,18,5,2,'08:45','11:55','On Time','Full',0,NULL,220.0);
INSERT INTO "schedules" VALUES(20,19,1,4,'09:30','11:30','On Time','High',0,NULL,140.0);
INSERT INTO "schedules" VALUES(21,20,2,5,'10:00','11:05','On Time','Medium',0,NULL,85.0);
INSERT INTO "schedules" VALUES(22,21,3,6,'10:45','12:00','On Time','Low',0,NULL,95.0);
INSERT INTO "schedules" VALUES(23,22,4,7,'12:15','13:05','Not Started','Low',0,NULL,60.0);
INSERT INTO "schedules" VALUES(24,23,1,8,'13:45','15:45','On Time','High',0,NULL,140.0);
INSERT INTO "schedules" VALUES(25,24,6,9,'14:30','16:30','On Time','Medium',0,NULL,160.0);
INSERT INTO "schedules" VALUES(26,25,2,10,'15:00','16:05','On Time','High',0,NULL,85.0);
INSERT INTO "schedules" VALUES(27,1,1,2,'16:30','18:30','On Time','Full',0,NULL,140.0);
INSERT INTO "schedules" VALUES(28,2,2,11,'17:30','18:35','Delayed','Medium',25,'Bridge repair near Nelamangala',85.0);
INSERT INTO "schedules" VALUES(29,3,3,12,'18:30','19:45','On Time','Low',0,NULL,95.0);
INSERT INTO "schedules" VALUES(30,5,4,13,'19:00','19:50','On Time','Medium',0,NULL,60.0);
INSERT INTO "schedules" VALUES(31,6,5,14,'19:30','22:40','On Time','High',0,NULL,220.0);
INSERT INTO "schedules" VALUES(32,7,1,15,'20:15','22:15','Not Started','Low',0,NULL,140.0);
INSERT INTO "schedules" VALUES(33,8,6,16,'21:00','23:00','On Time','Medium',0,NULL,160.0);
INSERT INTO "schedules" VALUES(34,9,2,17,'05:30','06:35','On Time','Low',0,NULL,85.0);
INSERT INTO "schedules" VALUES(35,10,3,18,'06:30','07:45','On Time','Medium',0,NULL,95.0);
INSERT INTO "schedules" VALUES(36,11,4,19,'07:00','07:50','On Time','Low',0,NULL,60.0);
INSERT INTO "schedules" VALUES(37,12,1,2,'07:45','09:45','On Time','High',0,NULL,140.0);
INSERT INTO "schedules" VALUES(38,13,6,4,'08:15','10:15','On Time','Full',0,NULL,160.0);
INSERT INTO "schedules" VALUES(39,14,2,5,'08:45','09:50','On Time','Medium',0,NULL,85.0);
INSERT INTO "schedules" VALUES(40,15,3,6,'09:00','10:15','On Time','Low',0,NULL,95.0);
INSERT INTO "schedules" VALUES(41,16,5,7,'09:30','12:40','On Time','High',0,NULL,220.0);
INSERT INTO "schedules" VALUES(42,17,1,8,'10:15','12:15','On Time','Medium',0,NULL,140.0);
INSERT INTO "schedules" VALUES(43,18,6,9,'11:00','13:00','On Time','High',0,NULL,160.0);
INSERT INTO "schedules" VALUES(44,19,2,10,'11:30','12:35','On Time','Low',0,NULL,85.0);
INSERT INTO "schedules" VALUES(45,20,3,11,'12:00','13:15','On Time','Medium',0,NULL,95.0);
INSERT INTO "schedules" VALUES(46,21,4,12,'12:45','13:35','On Time','Low',0,NULL,60.0);
INSERT INTO "schedules" VALUES(47,22,1,13,'13:15','15:15','On Time','High',0,NULL,140.0);
INSERT INTO "schedules" VALUES(48,23,6,14,'14:15','16:15','On Time','Medium',0,NULL,160.0);
CREATE TABLE stops (
        stop_id INTEGER PRIMARY KEY AUTOINCREMENT,
        route_id INTEGER NOT NULL,
        stop_name TEXT NOT NULL,
        sequence INTEGER NOT NULL,
        offset_minutes INTEGER NOT NULL,
        latitude REAL,
        longitude REAL,
        FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE
    );
INSERT INTO "stops" VALUES(1,1,'Tumkur KSRTC Bus Stand',1,0,13.3409,77.101);
INSERT INTO "stops" VALUES(2,1,'Kyathsandra Toll',2,15,13.3157,77.1592);
INSERT INTO "stops" VALUES(3,1,'Dabaspet Junction',3,35,13.2298,77.2417);
INSERT INTO "stops" VALUES(4,1,'Nelamangala Toll Gate',4,55,13.0984,77.3898);
INSERT INTO "stops" VALUES(5,1,'Nagasandra Metro',5,65,13.0475,77.4988);
INSERT INTO "stops" VALUES(6,1,'Yeshwanthpur TTMC',6,95,13.0234,77.5501);
INSERT INTO "stops" VALUES(7,1,'Bangalore Majestic (KBS)',7,120,12.9772,77.5729);
INSERT INTO "stops" VALUES(8,2,'Tumkur KSRTC Bus Stand',1,0,13.3409,77.101);
INSERT INTO "stops" VALUES(9,2,'Kyathsandra Toll',2,15,13.3157,77.1592);
INSERT INTO "stops" VALUES(10,2,'Hirehalli Industrial Area',3,25,13.275,77.198);
INSERT INTO "stops" VALUES(11,2,'Dabaspet Junction',4,38,13.2298,77.2417);
INSERT INTO "stops" VALUES(12,2,'Nelamangala Bypass',5,55,13.0984,77.3898);
INSERT INTO "stops" VALUES(13,2,'Nagasandra Metro Terminal',6,65,13.0475,77.4988);
INSERT INTO "stops" VALUES(14,3,'Tumkur KSRTC Bus Stand',1,0,13.3409,77.101);
INSERT INTO "stops" VALUES(15,3,'Urdigere Cross',2,20,13.312,77.21);
INSERT INTO "stops" VALUES(16,3,'Doddabelavangala',3,50,13.298,77.412);
INSERT INTO "stops" VALUES(17,3,'Doddaballapur Bus Stand',4,75,13.2925,77.5432);
INSERT INTO "stops" VALUES(18,4,'Tumkur KSRTC Bus Stand',1,0,13.3409,77.101);
INSERT INTO "stops" VALUES(19,4,'Kyathsandra',2,15,13.3157,77.1592);
INSERT INTO "stops" VALUES(20,4,'Dabaspet',3,35,13.2298,77.2417);
INSERT INTO "stops" VALUES(21,4,'Nelamangala TTMC',4,50,13.0984,77.3898);
INSERT INTO "stops" VALUES(22,5,'Tumkur Bus Stand',1,0,13.3409,77.101);
INSERT INTO "stops" VALUES(23,5,'Kunigal Bypass',2,40,13.0245,77.027);
INSERT INTO "stops" VALUES(24,5,'Maddur Circle',3,110,12.584,77.045);
INSERT INTO "stops" VALUES(25,5,'Mandya KSRTC Bus Stand',4,140,12.522,76.898);
INSERT INTO "stops" VALUES(26,5,'Mysore KSRTC Suburb Stand',5,190,12.3118,76.6529);
INSERT INTO "stops" VALUES(27,6,'Bangalore Majestic (KBS)',1,0,12.9772,77.5729);
INSERT INTO "stops" VALUES(28,6,'Yeshwanthpur TTMC',2,25,13.0234,77.5501);
INSERT INTO "stops" VALUES(29,6,'Nagasandra Metro',3,45,13.0475,77.4988);
INSERT INTO "stops" VALUES(30,6,'Nelamangala Toll Gate',4,65,13.0984,77.3898);
INSERT INTO "stops" VALUES(31,6,'Dabaspet Junction',5,85,13.2298,77.2417);
INSERT INTO "stops" VALUES(32,6,'Kyathsandra Toll',6,105,13.3157,77.1592);
INSERT INTO "stops" VALUES(33,6,'Tumkur KSRTC Bus Stand',7,120,13.3409,77.101);
CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone TEXT,
        password_hash TEXT NOT NULL,
        role TEXT NOT NULL CHECK(role IN ('admin', 'driver', 'passenger')),
        license_number TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
INSERT INTO "users" VALUES(1,'Admin In-Charge','admin@busflow.com','9845012345','scrypt:32768:8:1$d1GFbpzoNt7pnUGD$5407a2967807c61c45b564be55108996b0685409a4da63f1b9fe368d701c67bcb3ca10b2d492923d0db39f674a925e1a27ddccd1b795b0d9c73986e21961f267','admin',NULL,'2026-09-19 12:20:39');
INSERT INTO "users" VALUES(2,'Ravi Kumar','driver@busflow.com','9876543210','scrypt:32768:8:1$ARvlxJJSGApGxWXn$c3e6f46334b7da244ca1ff0106330b76c1739e350a3da80fc3fd3fde5edc8d6d9e5c2d0a2cc5e070ba68ff4e561fc7345580e6fbafc932ed5d52af0554b1f6a0','driver','KA-123456','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(3,'Skanda Bharadwaj','passenger@busflow.com','9123456780','scrypt:32768:8:1$odV69lB0J8igz4s4$c4fbdd8ae20101aa809e77a29ea0ed1dafc1432cbdddecb053154cfbbf10a11b942a05df367937a7216cc02a7175032a89efbd250e6926179f7bc60413eebb87','passenger',NULL,'2026-09-19 12:20:39');
INSERT INTO "users" VALUES(4,'Manjunath Gowda','manju@busflow.com','9880112233','scrypt:32768:8:1$pANIB9nl3E5OBPbf$077ad1976bc4f66d552d137be5316726ef873558655230a713d0641d27f1c7dce168a6044586e46e4c41a03fe4a884744c974840a2856dd05f482551051eb401','driver','KA-234567','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(5,'Suresh Nayak','suresh@busflow.com','9880223344','scrypt:32768:8:1$4PPMU6FfRKjjlCXq$04f7f9fc6babad3c048abe71fba868c4e492950fc3c35b8911e4eddb7ad87f8e0c6578b9de76d3b4e8082d3bea87b1a1b0319469a8f1bbd4ef6881b08a107752','driver','KA-345678','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(6,'Venkatesh Rao','venky@busflow.com','9880334455','scrypt:32768:8:1$6nA7kYVMS2gXaGNZ$86bc44e81a2995eb170f6342dc75b325f846281e02461057bb2c9444a9837ab91e97266bd163341c2d2e4955640eeed4ca2202415f66b8577bf7c2ce8720b5f0','driver','KA-456789','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(7,'Anand Swamy','anand@busflow.com','9880445566','scrypt:32768:8:1$CveF7ZRanUxtufK8$41e5c5435ef35ed7dba670b707652c7e92bb69ed8e22e0a81222c2760d51cba941194a8a17ec8030185962d2a8b9df01b6296355db5efa9aff8abd7c6ca384f9','driver','KA-567890','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(8,'Praveen Kumar','praveen@busflow.com','9880556677','scrypt:32768:8:1$aS963fiPOjAlwfu2$65f38dea72abf9572ed3dde1e1829da2de19dfe44643c21490598a0ba1d88a7f10f7eaf16f1d70dcdacdbcdd7a431ef2e8531c4f16a1de35b8bafa7bde4b7140','driver','KA-678901','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(9,'Basavaraj Patil','basava@busflow.com','9880667788','scrypt:32768:8:1$bA2hsyexvRpPwydg$7cb4e149f52896840a4d38a8f99757c7ea5632ce0309222d57d99e518f27e1f1083bf16dd9c282ac906ba67d0d94a0a3d405da880e51b143b0cc5c884dc1d172','driver','KA-789012','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(10,'Raghavendra Bhat','raghu@busflow.com','9880778899','scrypt:32768:8:1$rQfi1bJTcPtzOf5u$03dc992cc77d18e653aca961fa9f5ac0b5dfd7b0ee21b2c4073c017957b986aee2b7b9c9ff3af630d074cccd916a052bfb7868287c03d497020469d41bc24c19','driver','KA-890123','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(11,'Channappa M','channa@busflow.com','9880889900','scrypt:32768:8:1$lFqVkbPVowQCvCno$2e4bceab2364978416b0e56239a5bb3b6d8c5993ed53145032569ab5f4ddc285930922419cc9e64f6f41ac2f323f6b63ca80ce4e36e4c218884b0f569089467c','driver','KA-901234','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(12,'Girish Shetty','girish@busflow.com','9880990011','scrypt:32768:8:1$tWeAa8t9ekRQLsi3$8e4c1152a6b9ce437b63d1277d38120d7416e730ae7a502f6f7c3b35ba91a8ee737427abbdd2330917fa3beafa40b08c5c8577fb9bc18493760afe645b275e76','driver','KA-012345','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(13,'Shashidhar K','shashi@busflow.com','9881001122','scrypt:32768:8:1$BCoo1PyUoLNC5VCM$3976acc8822eb83550730a19dc9807d69cac8e703d883025ee1b3cc497465915ef3eef238cdab7841329f0572406475c2adb2e8f06793d706af87a7515cc7405','driver','KA-112233','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(14,'Kiran Prasad','kiran@busflow.com','9881112233','scrypt:32768:8:1$ipEtlBai6PHo2PPm$0ddfdb81ac04ba5f149129fd5f6d34b6615c6cbb3e8f71074a9b58109749d5730bd7b4c8cc0b25994f92c4dca89d0a46f9b3b663865cfbcc01a53423bcd960af','driver','KA-223344','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(15,'Mahesh Hegde','mahesh@busflow.com','9881223344','scrypt:32768:8:1$0zVFrQjU1f9aCZtG$09a5e7ee2bee06f0199c1eafd8e8ac922fa184894310ba62327272eafce387f3488bf0c93945b12ce971be7c39b063974599e41f1cd533fc313a6f07ae436331','driver','KA-334455','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(16,'Nagaraj Reddy','nagaraj@busflow.com','9881334455','scrypt:32768:8:1$kmH70I2rnafJ0FfS$5c99d39f82dcd0e6deb7aefd8165e43a17a033e2a6c9ba36008365581d3e780aba5ea3c94857aa15a5f37be5bb8fb31e0d7453ab55c4ada846af1349fd046629','driver','KA-445566','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(17,'Shivakumar B','shiva@busflow.com','9881445566','scrypt:32768:8:1$mmV6xFXXsCDV2obP$b28776615ffc8b7f37d90aed4c859de4d01db849badbe00bd33093d880de7e1b8a32bee77b1d7ae752618ef43ea2f9cf18449db3674878ec776420cfdbf76c18','driver','KA-556677','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(18,'Ramesh Chandra','ramesh@busflow.com','9881556677','scrypt:32768:8:1$82t22dwFhaCAOl4p$85aea23e7f6e72fd6fb3f36785003e7790f93a911792a20228e8e2c5f7d685c1f7df33e50cad4983fac920ad20a80bf7fd10d3ac6b39870079ffd99ed20bc3f8','driver','KA-667788','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(19,'Vijay Kumar','vijay@busflow.com','9881667788','scrypt:32768:8:1$Gx91SbgytNc6vgwU$0c5b122f1df8577deaa7f469d843b914c9bd94576432a8bfeac4c793318dd5e33c280cbf796430d68054b11f5300b157297a09219d50ad4dd36517f5a31d2177','driver','KA-778899','2026-09-19 12:20:39');
INSERT INTO "users" VALUES(20,'Ananya Sharma','ananya@example.com','9900112233','scrypt:32768:8:1$OwJa6PGJJrjwd7ow$1b4a90e6763eb92165d35a13601df599005b0c980f8371c85b59c33ecbb2a6f6165f1185e3d58403185fdf243960d51c7d0ebeadbc09ce781f9f48b4b5cd1d74','passenger',NULL,'2026-09-19 12:20:39');
INSERT INTO "users" VALUES(21,'Karthik Varma','karthik@example.com','9900223344','scrypt:32768:8:1$ac7lKlU3H7oTTn6K$e69eac1d61dfb044a802c2dc5d390162e2c4b867898881315ec920ef921ba77700619346eadd3497bcd4bdc6719b580b61977bc1f51ad74c09acb8f39a8f2880','passenger',NULL,'2026-09-19 12:20:39');
DELETE FROM "sqlite_sequence";
INSERT INTO "sqlite_sequence" VALUES('users',21);
INSERT INTO "sqlite_sequence" VALUES('buses',25);
INSERT INTO "sqlite_sequence" VALUES('routes',12);
INSERT INTO "sqlite_sequence" VALUES('stops',33);
INSERT INTO "sqlite_sequence" VALUES('schedules',48);
INSERT INTO "sqlite_sequence" VALUES('delays',4);
INSERT INTO "sqlite_sequence" VALUES('bookings',6);
INSERT INTO "sqlite_sequence" VALUES('driver_shifts',7);
COMMIT;
