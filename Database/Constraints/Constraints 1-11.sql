go
/*==============================================================*/
/*				Constraintname: BikeAvailability				*/
/* A customer can't rent a bike if it's already being rented,	*/
/*it is locked by an employee or being repaired in a workshop.	*/
/*==============================================================*/
CREATE TRIGGER trgBikeAvailability
On RENTAL
AFTER INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0 BEGIN RETURN END
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS	(SELECT 1 FROM INSERTED I											--If exists one of the inserted rows where:
					WHERE BIKEID IN (SELECT BIKEID FROM POST WHERE LOCKED = 'true')		--If a bike is locked																				
					OR BIKEID IN (SELECT BIKEID FROM BIKE WHERE WORKSHOPID IS NOT NULL)							--If a bike is in a workshop
					OR BIKEID IN (SELECT BIKEID FROM RENTAL WHERE ENDTIME IS NULL AND RENTALID != I.RENTALID)	--If a bike is being rented
					)
		BEGIN
			;THROW 50000,'The desired bike is not available, please select another bike.',1
		END
	END TRY
	BEGIN CATCH
		THROW
	END CATCH
END

go
--END CONTRAINT #1
--TEST CONTRAINT #1
					--CREATING TEST DATA
INSERT INTO BIKE(BIKEID, WORKSHOPID, [TYPE]) VALUES (100000, NULL, 'Adult'),--normal bike
													(100001, 1, 'Adult'),	--bike in repair
													(100002, NULL, 'Adult'),	--bike that is going to be locked
													(100003, NULL, 'Adult'),	--bike that's being rented
													(100004, NULL, 'Adult')	--another normal bike
INSERT INTO STATION(STATIONID, STATIONNR, [ZONE], [TYPE], MAXPOSTS) VALUES (100000, 100000, 21, 'normal', 70)-- empty test station
INSERT INTO POST (POSTID, STATIONID, BIKEID, LOCKED) VALUES (1, 100000, 100000, 0),--unlocked normal bike
															(2, 100000, 100002, 1) --locked bike
INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID)
			VALUES (100000, 100003, 1, 100000, NULL, NULL, CURRENT_TIMESTAMP, NULL, NULL, NULL, 0)--rental of bike 100003
					--PERFORMING TESTS
BEGIN TRAN
--1 good insert
INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID)
			VALUES (100004, 100000, 1, 100000, NULL, NULL, CURRENT_TIMESTAMP, NULL, NULL, NULL, 0)
--1 bad insert, bike in repair
INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID)
			VALUES (100002, 100001, 1, 100000, NULL, NULL, CURRENT_TIMESTAMP, NULL, NULL, NULL, 0)
--1 bad insert, bike's station is locked
INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID)
			VALUES (100002, 100002, 1, 100000, NULL, NULL, CURRENT_TIMESTAMP, NULL, NULL, NULL, 0)
--1 bad insert, bike is being rented
INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID)
			VALUES (100003, 100003, 1, 100000, NULL, NULL, CURRENT_TIMESTAMP, NULL, NULL, NULL, 0)
--2 good inserts
INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID)
			VALUES (100002, 100000, 1, 100000, NULL, NULL, CURRENT_TIMESTAMP, NULL, NULL, NULL, 0),
				   (100004, 100004, 2, 100000, NULL, NULL, CURRENT_TIMESTAMP-1, NULL, NULL, NULL, 0)
--2 inserts, 1 good, 1 bad
INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID)
			VALUES (100005, 100000, 1, 100000, NULL, NULL, CURRENT_TIMESTAMP, NULL, NULL, NULL, 0),
				   (100003, 100003, 1, 100000, NULL, NULL, CURRENT_TIMESTAMP-1, NULL, NULL, NULL, 0)
+
--END TEST CONTRAINT #1








GO
--BEGIN CONSTRAINT #2

CREATE TRIGGER trgConstraint2_POST_nPostsLessThanMaxPosts --DROP TRIGGER trgConstraint2_POST_nPostsLessThanMaxPosts
On POST
AFTER INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0 BEGIN RETURN END
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS	(SELECT 1 FROM POST P WHERE EXISTS --If exists a station with more than [MaxPosts] posts
							(SELECT 1 FROM POST POS INNER JOIN STATION S 
							ON POS.STATIONID = S.STATIONID
							WHERE P.STATIONID = POS.STATIONID GROUP BY POS.STATIONID, S.MAXPOSTS HAVING COUNT(POS.STATIONID) > S.MAXPOSTS )
					)
		BEGIN
			;THROW 50000,'The number of posts can''t exceed the maxPosts value',1
		END
	END TRY
	BEGIN CATCH
		THROW
	END CATCH
END

go
--END CONTRAINT #2
--TEST CONTRAINT #2
BEGIN TRAN
							--CREATING TEST DATA
INSERT INTO STATION(STATIONID, STATIONNR, [ZONE], [TYPE], MAXPOSTS) VALUES (200000, 20, 21, 'normal', 4)--
INSERT INTO POST(POSTID, STATIONID, BIKEID, LOCKED) VALUES (1, 200000, NULL, 0),
														   (2, 200000, NULL, 0) 
							--PERFOMING TESTS
--1 GOOD INSERT
INSERT INTO POST(POSTID, STATIONID, BIKEID, LOCKED) VALUES (3, 200000, NULL, 0)
--2 GOOD INSERTS
INSERT INTO POST(POSTID, STATIONID, BIKEID, LOCKED) VALUES (3, 200000, NULL, 0),
														   (4, 200000, NULL, 0)
--1 BAD INSERT
INSERT INTO POST(POSTID, STATIONID, BIKEID, LOCKED) VALUES (3, 200000, NULL, 0),
														   (4, 200000, NULL, 0)
INSERT INTO POST(POSTID, STATIONID, BIKEID, LOCKED) VALUES (5, 200000, NULL, 0)
--2 BAD INSERTS
INSERT INTO POST(POSTID, STATIONID, BIKEID, LOCKED) VALUES (3, 200000, NULL, 0),
														   (4, 200000, NULL, 0)
INSERT INTO POST(POSTID, STATIONID, BIKEID, LOCKED) VALUES (5, 200000, NULL, 0),
														   (6, 200000, NULL, 0)
--1 GOOD INSERT, 1 BAD INSERT
INSERT INTO POST(POSTID, STATIONID, BIKEID, LOCKED) VALUES (3, 200000, NULL, 0)
INSERT INTO POST(POSTID, STATIONID, BIKEID, LOCKED) VALUES (4, 200000, NULL, 0),
														   (5, 200000, NULL, 0)
-----------------------------------
ROLLBACK

/*==============================================================*/
/*			run this first before testing the constraints		*/
/*==============================================================*/
BEGIN TRAN
update repairlog set date = getdate() - 10 where repairid in (select repairid from repairlog where date > getdate())
insert into rental values (1005,134,13,628,931,null,'2016-11-24 08:34:00.410','2016-11-26 13:52:00.410',7,0,0)
update post set locked = 0 where bikeid is null
update post set locked = 1 where bikeid is not null
delete from post where postid = 1000

COMMIT
/*==============================================================*/
/*							Constraints							*/
/*==============================================================*/

/*==========================Constraint 3========================*/
--Een fiets wordt na 2 maanden, of wanneer hij 100x is uitgeleend of 100x een half uur gefietst heeft, gerepareerd

--Dit kan wel want deze bike is in de afgelopen twee maanden wel naar de workshop geweest en voldoet ook aan de andere eisen.
BEGIN TRAN
INSERT INTO rental VALUES (1001,74,13,629,931,null,'2016-11-26 08:58:00.410','2016-11-26 10:58:00.410',7,0,0)

ROLLBACK
--Dit kan niet want deze bike is in de afgelopen twee maanden niet langs de workshop geweest.
INSERT INTO rental VALUES (1001,74,13,629,931,null,'2016-11-26 08:58:00.410','2016-11-26 10:58:00.410',7,0,0),(1002,1,13,629,931,null,'2016-11-26 08:59:00.410','2016-11-26 10:58:00.410',7,0,0)

--Dit kan niet want deze bike is al 50:00:00 uur lang uitgeleend zonder voor het laatst naar de workshop te zijn geweest.
INSERT INTO rental VALUES (1001,74,13,629,931,null,'2016-11-26 08:58:00.410','2016-11-26 10:58:00.410',7,0,0),(1006,134,13,628,931,null,'2016-12-1 08:40:00.410','2016-12-1 11:40:00.410',7,0,0)

--Dit kan niet want deze bike is al 100x uitgeleend zonder naar de workshop te zijn geweest
--niet zoveel zin om handmatig 100 rows toe te voegen met allemaal een sum van minder dan die 50 uur voor dezelfde fiets om deze constraint te testen :\
--Via redgate?

--DROP TRIGGER trgConstraint1
CREATE TRIGGER trgConstraint1
ON RENTAL
AFTER INSERT,UPDATE
AS
BEGIN
IF @@ROWCOUNT = 0 BEGIN RETURN END
SET NOCOUNT ON
BEGIN TRY
	IF EXISTS(SELECT 1
	FROM REPAIRLOG r 
	INNER JOIN BIKE b
	ON b.bikeid= r.bikeid
	INNER JOIN INSERTED i
	ON i.bikeid = b.bikeid
	group by r.date, b.bikeid
	having (getdate() - max(r.date)  ) >= 60)
	BEGIN
		;THROW 50000,'Deze fiets is al twee maanden niet meer gerepareerd, hij zal eerst gerepareerd moeten worden.',1
	END

	IF EXISTS(SELECT 1
	FROM RENTAL r 
	INNER JOIN BIKE b 
	ON r.bikeid = b.bikeid
	INNER JOIN REPAIRLOG rl
	ON r.bikeid = rl.bikeid
	INNER JOIN INSERTED i 
	ON i.bikeid = r.bikeid
	GROUP BY b.bikeid,r.rentalid,r.endtime
	HAVING count(r.rentalid) >= 100 and r.endtime > max(rl.date))
	BEGIN
		;THROW 50000,'Deze fiets is al honderd keer uitgeleend, hij zal eerst gerepareerd moeten worden.',1
	END

	IF (SELECT sum(aantal) FROM 
	(SELECT b.bikeid,sum(datediff(hh,r.begintime,r.endtime)) as aantal
	FROM rental r 
	INNER JOIN BIKE b 
	ON r.bikeid = b.bikeid
	INNER JOIN REPAIRLOG rl
	ON r.bikeid = rl.bikeid
	INNER JOIN INSERTED i
	ON i.bikeid = b.bikeid
	WHERE r.bikeid = 134
	GROUP BY b.bikeid,r.begintime,r.endtime
	HAVING r.endtime > max(rl.date)) as table1) > 50
	BEGIN
		;THROW 50000,'Deze fiets is al 50 uur in gebruik geweest nadat hij voor het laatst naar een techinician is geweest, hij zal eerst gerepareerd moeten worden.',1
	END
END TRY
BEGIN CATCH
	THROW
END CATCH
END

---------------------------------CONSTRAINT: 4-----------------------------

----------------------TRIGGER------------------------
CREATE TRIGGER trgPrepaidcard
ON [user]
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0 BEGIN RETURN END
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS (
			SELECT * 
			FROM inserted i
			INNER JOIN subscription s
			ON i.subscriptionid = s.subscriptionid
			WHERE s.longterm = 0
			AND i.prepaidcard = 1)
		BEGIN
			;THROW 50000, 'Alleen long-term users kunnen gebruik maken van een prepaidcard.', 1
		END
	END TRY
	BEGIN CATCH
		THROW
	END CATCH
END


------------------------Tests-------------------------
BEGIN TRAN
	--Werkt wel, want deze user heeft een longterm subscription
	INSERT INTO [dbo].[USER] ([USERID], [SUBSCRIPTIONID], [FIRSTNAME], [LASTNAME], [DATEOFBIRTH], [ZIPCODE], [ADDRESS], [TOWN], [EMAIL], [CREDITCARD], [PHONENUMBER], [VPOINTS], [DISCOUNT], [SUBSCRIPTIONSTART], [SUBSCRIPTIONREFRESH], [PREPAIDCARD]) 
	VALUES (10001, 1, 'Claire', 'Mccarty', '1962-01-09', '14727', '641 Hague Boulevard', 'Minneapolis', 'swrsujwrro.tchbdaueb@qfokskg.qii-vi.com', '5458885096079165', '647-7588701 ', 1959729659, 15.0000, '2003-02-09 06:08:12.730', 1, 1)
ROLLBACK TRAN

BEGIN TRAN
	--Werkt wel, want deze users hebben een longterm subscription
	INSERT INTO [dbo].[USER] ([USERID], [SUBSCRIPTIONID], [FIRSTNAME], [LASTNAME], [DATEOFBIRTH], [ZIPCODE], [ADDRESS], [TOWN], [EMAIL], [CREDITCARD], [PHONENUMBER], [VPOINTS], [DISCOUNT], [SUBSCRIPTIONSTART], [SUBSCRIPTIONREFRESH], [PREPAIDCARD]) 
	VALUES (10001, 1, 'Claire', 'Mccarty', '1962-01-09', '14727', '641 Hague Boulevard', 'Minneapolis', 'swrsujwrro.tchbdaueb@qfokskg.qii-vi.com', '5458885096079165', '647-7588701 ', 1959729659, 15.0000, '2003-02-09 06:08:12.730', 1, 1),
		   (10002, 1, 'Claire', 'Mccarty', '1962-01-09', '14727', '641 Hague Boulevard', 'Minneapolis', 'swrsujwrro.ftchbdaueb@qfokskg.qii-vi.com', '5458885096079165', '647-7588701 ', 1959729659, 15.0000, '2003-02-09 06:08:12.730', 1, 1)
ROLLBACK TRAN

BEGIN TRAN
	--Werkt niet, want deze user heeft geen longterm subscription
	INSERT INTO [dbo].[USER] ([USERID], [SUBSCRIPTIONID], [FIRSTNAME], [LASTNAME], [DATEOFBIRTH], [ZIPCODE], [ADDRESS], [TOWN], [EMAIL], [CREDITCARD], [PHONENUMBER], [VPOINTS], [DISCOUNT], [SUBSCRIPTIONSTART], [SUBSCRIPTIONREFRESH], [PREPAIDCARD]) 
	VALUES (10001, 2, 'Claire', 'Mccarty', '1962-01-09', '14727', '641 Hague Boulevard', 'Minneapolis', 'swrsujwrro.tchbdaueb@qfokskg.qii-vi.com', '5458885096079165', '647-7588701 ', 1959729659, 15.0000, '2003-02-09 06:08:12.730', 1, 1)
ROLLBACK TRAN

---------------------------------CONSTRAINT: 5-----------------------------


--------------------------TRIGGER--------------------------
CREATE TRIGGER trgVplusPoints
ON rental
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0 BEGIN RETURN END
	SET NOCOUNT ON
	BEGIN TRY
		IF UPDATE(endtime)
		BEGIN
			IF EXISTS(
				SELECT *
				FROM inserted i 
				INNER JOIN station s 
				ON i.endstationid = s.stationid
				WHERE s.type = 'v+'
				AND
				DATEDIFF(mi, i.begintime, i.endtime) < 30
				AND
				DATEDIFF(mi, i.begintime, i.endtime) > 0)
			BEGIN
				UPDATE [user]
				SET vPoints = vPoints+15
				FROM inserted i
				INNER JOIN [user] u
				ON u.userid = i.userid
			END
		END
	END TRY
	BEGIN CATCH
		THROW
	END CATCH
END


---------------------------Tests---------------------------
BEGIN TRAN
	INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID) 
	VALUES (118001, 647, 293, 96, 96, 1787, '2010-09-07 02:21:29.950', null, 513.5759, 30, 0)

	--Vpoints worden niet geadd, omdat het verschil tussen begin- en eindtijd niet negatief kan zijn.
	UPDATE RENTAL
	SET ENDTIME = '2001-12-27 02:08:44.990'
	WHERE RENTALID = 118001
ROLLBACK TRAN

BEGIN TRAN
	--Vpoints worden niet geadd, omdat het verschil tussen begin- en eindtijd > 30
	INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID) 
	VALUES (118001, 647, 293, 96, 96, 1787, '2010-09-07 02:21:29.950', '2010-09-07 03:21:29.950', 513.5759, 30, 0)
ROLLBACK TRAN

BEGIN TRAN
	--Vpoints worden geadd, omdat het verschil tussen begin- en eindtijd < 30
	INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID) 
	VALUES (118001, 647, 293, 96, 96, 1787, '2010-09-07 02:21:29.950', '2010-09-07 02:41:29.950', 513.5759, 30, 0)
ROLLBACK TRAN

BEGIN TRAN
	--Vpoints van meerdere inserts worden geadd, omdat het verschil tussen begin- en eindtijd < 30
	INSERT INTO RENTAL (RENTALID, BIKEID, USERID, BEGINSTATIONID, ENDSTATIONID, INVOICEID, BEGINTIME, ENDTIME, PRICE, EXTENDEDTIME, PAID) 
	VALUES (118001, 647, 292, 96, 96, 1787, '2010-09-07 02:21:29.950', '2010-09-07 02:41:29.950', 513.5759, 30, 0),
		   (118002, 647, 293, 96, 96, 1787, '2010-09-06 02:21:29.950', '2010-09-06 02:42:29.950', 513.5759, 30, 0)
ROLLBACK TRAN

--6. Als er langer is uitgeleend dan de maximale tijd van een abonnement, 
--   dan moet er per tijdsinterval een 'boete' bij het bedrag worden opgeteld

DROP PROC spBoeteBerekenen
CREATE PROC spBoeteBerekenen
  @USERID int,
  @RENTALID int
AS
BEGIN
	SET NOCOUNT ON
		BEGIN TRY
			IF @@TRANCOUNT > 0
				BEGIN
				SAVE TRAN IncheckenBijMaatschappij
				END
			
		DECLARE @PaidTime int;
		DECLARE @Price decimal(19,4);

		SELECT @Price = 0


	-- DE GEREDEN TIJD WORDT IN EEN VARIABELE GEZET EN DE FREE SUBSCRIPTIONTIME (30 of 45 minuten) WORDT ER AF GEHAALD
			SELECT @PaidTime = (datediff(mi,BEGINTIME,ENDTIME) - MAXFREETIME)  
			FROM RENTAL R INNER JOIN [USER] U 
				 ON R.USERID = U.USERID 
				 INNER JOIN SUBSCRIPTION S 
				 ON S.SUBSCRIPTIONID = U.SUBSCRIPTIONID
		    WHERE R.USERID = @USERID
				  AND
				  R.RENTALID = @RENTALID
		PRINT @PaidTime
	-- DE USER IS BIJ EEN V+ STATION
			IF (SELECT [TYPE] FROM STATION WHERE STATIONID = (SELECT ENDSTATIONID FROM RENTAL WHERE RENTALID = @RENTALID)) = 'V+'
				BEGIN
					SELECT @PaidTime = @PaidTime - 15
				END
		PRINT @PaidTime
	-- HET STATION IS VOL DUS 15 MINUTEN GRATIS TIJD
			IF (SELECT EXTENDEDTIME FROM RENTAL WHERE RENTALID = @RENTALID) > 0
				BEGIN 
					SELECT @PaidTime = @PaidTime - (SELECT EXTENDEDTIME FROM RENTAL WHERE RENTALID = @RENTALID)
				END
		PRINT @PaidTime
	-- DE VPOINTS WORDEN ER AF GEHAALD
			IF ((SELECT VPOINTS FROM [USER] WHERE USERID = @USERID) > 0) AND (@PaidTime > (SELECT VPOINTS FROM [USER] WHERE USERID = @USERID))
				BEGIN
					SELECT @PaidTime = @PaidTime - (SELECT VPOINTS FROM [USER] WHERE USERID = @USERID)

					UPDATE [USER]
					SET VPOINTS = 0
					WHERE USERID = @USERID					
				END
			ELSE IF ((SELECT VPOINTS FROM [USER] WHERE USERID = @USERID) > 0) AND (@PaidTime < (SELECT VPOINTS FROM [USER] WHERE USERID = @USERID))
				BEGIN
					UPDATE [USER]
					SET VPOINTS = VPOINTS - @PaidTime
					WHERE USERID = @USERID

					SELECT @PaidTime = 0
				END
		PRINT @PaidTime
	--BOETE WORDT BEREKENT
		-- Halfuur te lang gereden
			IF @PaidTime > 0
			BEGIN
			SELECT @Price = @Price + (SELECT Price FROM RENTALPRICE WHERE [TIME] = 30)
			END
		-- Uur te lang gereden
			IF @PaidTime > 30
			BEGIN
			SELECT @Price = @Price + (SELECT Price FROM RENTALPRICE WHERE [TIME] = 60)
			END
		-- Anderhalfuur te lang gereden
			IF @PaidTime > 60
			BEGIN
			SELECT @Price = @Price + (SELECT Price FROM RENTALPRICE WHERE [TIME] = 90) 
			END
		-- Meer dan anderhalfuur te lang gereden
			IF @PaidTime > 90
			BEGIN
				DECLARE @VALUE int;
				SELECT @VALUE = (@PaidTime - 90) / 30
				SELECT @Price = @Price + ((SELECT Price FROM RENTALPRICE WHERE [TIME] = 90) * @VALUE)
			END

			PRINT @Price
		-- UPDATE DE PRIJS
			UPDATE RENTAL
			SET PRICE = @Price
			WHERE RENTALID = @RENTALID

			PRINT @Price
			PRINT @RENTALID

	END TRY
		BEGIN CATCH
		IF @@TRANCOUNT > 0
		SAVE TRAN IncheckenBijMaatschappij
			;THROW
		END CATCH
END

INSERT INTO RENTALPRICE([TIME],PRICE) VALUES (30,1)
INSERT INTO RENTALPRICE([TIME],PRICE) VALUES (60,2)
INSERT INTO RENTALPRICE([TIME],PRICE) VALUES (90,4)

---------- TEST CASES-----------

SELECT * FROM RENTAL
SELECT * FROM [USER]


--WORDT CORRECT UITGEVOERD: Boete van 23 euro
BEGIN TRAN

-- INSERT USER 1001 MET 15 VPOINTS
INSERT INTO [dbo].[USER] ([USERID], [SUBSCRIPTIONID], [FIRSTNAME], [LASTNAME], [DATEOFBIRTH], [ZIPCODE], [ADDRESS], [TOWN], [EMAIL], 
[CREDITCARD], [PHONENUMBER], [VPOINTS], [DISCOUNT], [SUBSCRIPTIONSTART], [SUBSCRIPTIONREFRESH], [PREPAIDCARD]) 
VALUES (1001, 4, 'Sacha', 'Boone', '1973-09-07', '39532', '165 Green Milton Boulevard', 'Washington', 'kffsqsa.kqxiqmqz@ipfhlqs.ifldff.net', 
'5241800812097740', '386-067-0800', 15, 15.0000, '2002-12-28 01:55:01.280', 0, 1)

-- INSERT RENTAL 1001 VAN USER 1001 WAAR DE PRIJS NOG NULL IS EN DE EXTENDEDTIME 30
INSERT INTO [dbo].[RENTAL] ([RENTALID], [BIKEID], [USERID], [BEGINSTATIONID], [ENDSTATIONID], 
[INVOICEID], [BEGINTIME], [ENDTIME], [PRICE], [EXTENDEDTIME], [PAID]) 
VALUES (1001, 685, 1001, 677, 677, 1753, '2005-12-17 13:30:35.810','2005-12-17 18:30:35.050', NULL, 30, 0)

--TIME      - MAXFREETIME(Subscription free time)     - V+Station - EXTENDEDTIME(Stations waren vol dus extra tijd)     - VPOINTS = PaidTime
-- 300		-		11								  -    15	  -			30											-	15	  = 229 minuten
-- 229 minuten extra betekend 1,2 en dan 4 betalen = 7 euro
-- 229 minuten extra betekend voor elk halfuur meer dan 90 minuten 4 euro extra betalen = 16 euro
-- 7 + 16 = 23 euro betalen
-- Price moet 23 euro worden
EXEC spBoeteBerekenen 1001,1001

SELECT * FROM RENTAL WHERE RENTALID = 1001

ROLLBACK TRAN



--------------------------------------------------------------------------------------------------------------------------------------------


--WORDT CORRECT UITGEVOERD: Boete van 0 euro (geen boete)
BEGIN TRAN

-- INSERT USER 1001 MET 400 VPOINTS
INSERT INTO [dbo].[USER] ([USERID], [SUBSCRIPTIONID], [FIRSTNAME], [LASTNAME], [DATEOFBIRTH], [ZIPCODE], [ADDRESS], [TOWN], [EMAIL], 
[CREDITCARD], [PHONENUMBER], [VPOINTS], [DISCOUNT], [SUBSCRIPTIONSTART], [SUBSCRIPTIONREFRESH], [PREPAIDCARD]) 
VALUES (1001, 4, 'Sacha', 'Boone', '1973-09-07', '39532', '165 Green Milton Boulevard', 'Washington', 'kffsqsa.kqxiqmqz@ipfhlqs.ifldff.net', 
'5241800812097740', '386-067-0800', 400, 15.0000, '2002-12-28 01:55:01.280', 0, 1)

-- INSERT RENTAL 1001 VAN USER 1001 WAAR DE PRIJS NOG NULL IS EN DE EXTENDEDTIME 30
INSERT INTO [dbo].[RENTAL] ([RENTALID], [BIKEID], [USERID], [BEGINSTATIONID], [ENDSTATIONID], 
[INVOICEID], [BEGINTIME], [ENDTIME], [PRICE], [EXTENDEDTIME], [PAID]) 
VALUES (1001, 685, 1001, 677, 677, 1753, '2005-12-17 13:30:35.810','2005-12-17 18:30:35.050', NULL, 0, 0)

--TIME      - MAXFREETIME(Subscription free time)     - V+Station - EXTENDEDTIME(Stations waren vol dus extra tijd)     - VPOINTS = PaidTime
-- 300		-		11								  -    15	  -			0											-	400	  = 0 minuten
-- 0 minuten extra betekend 1,2 en dan 4 niet betalen = 0 euro
-- 0 minuten extra betekend voor elk halfuur meer dan 90 minuten 4 euro extra betalen = 0 euro
-- 0 + 0 = 0 euro betalen
-- Price moet 0 euro worden
EXEC spBoeteBerekenen 1001,1001

SELECT * FROM RENTAL WHERE RENTALID = 1001

ROLLBACK TRAN

--7. EndTime mag pas ingevuld worden als BeginTime is ingevuld

ALTER TABLE RENTAL
ADD CHECK ((endtime is null and begintime is not null) 
		   or
	       (begintime is not null and endtime is not null))

---------- TEST CASES-----------

-- Allebei = NOT NULL		WERKT
BEGIN TRAN
INSERT INTO [dbo].[RENTAL] ([RENTALID], [BIKEID], [USERID], [BEGINSTATIONID], [ENDSTATIONID], [INVOICEID], [BEGINTIME], [ENDTIME], [PRICE], [EXTENDEDTIME], [PAID]) 
VALUES (1001, 686, 413, 677, 677, 1753, '2005-12-17 13:49:35.810', '2005-12-18 10:55:47.050', 316.5149, 30, 0)
ROLLBACK TRAN

-- EndTime = NULL			WERKT
BEGIN TRAN
INSERT INTO [dbo].[RENTAL] ([RENTALID], [BIKEID], [USERID], [BEGINSTATIONID], [ENDSTATIONID], [INVOICEID], [BEGINTIME], [ENDTIME], [PRICE], [EXTENDEDTIME], [PAID]) 
VALUES (1001, 686, 413, 677, 677, 1753, '2005-12-17 13:49:35.810',NULL, 316.5149, 30, 0)
ROLLBACK TRAN

-- BeginTime = NULL			WERKT NIET
BEGIN TRAN
INSERT INTO [dbo].[RENTAL] ([RENTALID], [BIKEID], [USERID], [BEGINSTATIONID], [ENDSTATIONID], [INVOICEID], [BEGINTIME], [ENDTIME], [PRICE], [EXTENDEDTIME], [PAID]) 
VALUES (1001, 686, 413, 677, 677, 1753, NULL, '2005-12-18 10:55:47.050', 316.5149, 30, 0)
ROLLBACK TRAN

-- Allebei = IS NULL		WERKT NIET
BEGIN TRAN
INSERT INTO [dbo].[RENTAL] ([RENTALID], [BIKEID], [USERID], [BEGINSTATIONID], [ENDSTATIONID], [INVOICEID], [BEGINTIME], [ENDTIME], [PRICE], [EXTENDEDTIME], [PAID]) 
VALUES (1001, 686, 413, 677, 677, 1753, NULL,NULL, 316.5149, 30, 0)
ROLLBACK TRAN

--Lex-- 8 Kortingen mogen alleen bestaan voor long-term gebruikers

CREATE TRIGGER trgDiscountUser
ON [User]
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0 RETURN 
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN
			IF EXISTS (SELECT 1 
						FROM inserted i
						INNER JOIN SUBSCRIPTION s
						ON i.SUBSCRIPTIONID = s.SUBSCRIPTIONID
						WHERE i.DISCOUNT != 0 
						AND s.LONGTERM = 0)		
			BEGIN
				;THROW 50000, 'Alleen long-term users kunnen gebruik maken van kortingen.', 1
			END
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

--WERKT WEL
BEGIN TRAN
INSERT INTO [dbo].[USER] ([USERID], [SUBSCRIPTIONID], [FIRSTNAME], [LASTNAME], [DATEOFBIRTH], [ZIPCODE], [ADDRESS], [TOWN], [EMAIL], [CREDITCARD], [PHONENUMBER], [VPOINTS], [DISCOUNT], [SUBSCRIPTIONSTART], [SUBSCRIPTIONREFRESH], [PREPAIDCARD]) 
VALUES (10001, 1, 'Claire', 'Mccarty', '1962-01-09', '14727', '641 Hague Boulevard', 'Minneapolis', 'swrsujwrro.tchbdaueb@qfokskg.qii-vi.com', '5458885096079165', '647-7588701 ', 1959729659, 15.0000, '2003-02-09 06:08:12.730', 1, 1)

rollback

--WERKT NIET
INSERT INTO [dbo].[USER] ([USERID], [SUBSCRIPTIONID], [FIRSTNAME], [LASTNAME], [DATEOFBIRTH], [ZIPCODE], [ADDRESS], [TOWN], [EMAIL], [CREDITCARD], [PHONENUMBER], [VPOINTS], [DISCOUNT], [SUBSCRIPTIONSTART], [SUBSCRIPTIONREFRESH], [PREPAIDCARD]) 
VALUES (10001, 2, 'Claire', 'Mccarty', '1962-01-09', '14727', '641 Hague Boulevard', 'Minneapolis', 'swrsujwrro.tchbdaueb@qfokskg.qii-vi.com', '5458885096079165', '647-7588701 ', 1959729659, 15.0000, '2003-02-09 06:08:12.730', 1, 1)

--WERKT NIET
INSERT INTO [dbo].[USER] ([USERID], [SUBSCRIPTIONID], [FIRSTNAME], [LASTNAME], [DATEOFBIRTH], [ZIPCODE], [ADDRESS], [TOWN], [EMAIL], [CREDITCARD], [PHONENUMBER], [VPOINTS], [DISCOUNT], [SUBSCRIPTIONSTART], [SUBSCRIPTIONREFRESH], [PREPAIDCARD]) 
VALUES (100001, 1, 'Sherri', 'Kirk', '1958-05-09', '48125', '608 North Green Fabien Parkway', 'Miami', 'cmmiteexw.ulrnbvcrxy@pawbgnhe.ipphsw.net', '5147090167254576', '882-2115300 ', 1417180110, 0.0000, '1958-12-27 22:11:17.180', 1, 1)
,(100002, 2, 'Claire', 'Mccarty', '1962-01-09', '14727', '641 Hague Boulevard', 'Minneapolis', 'swrsujrrwo.tchbdaueb@qfokskg.qii-vi.com', '5458885096079165', '647-7588701 ', 1959729659, 15.0000, '2003-02-09 06:08:12.730', 1, 1)


--Lex-- 9 Een gebruiker mag maar 1 fiets per keer huren
--Vooraf inserten
INSERT INTO rental values (2001,358,296,479,331,null,'2016-12-4 11:29:56.150',null,null,null,null)

--Werkt wel
begin tran
INSERT INTO rental values (2003,467,292,476,331,null,'2016-12-4 11:32:56.150',null,null,null,null)
rollback
--Werkt niet
INSERT INTO rental values (2002,367,296,479,331,null,'2016-12-4 11:31:56.150',null,null,null,null)

--Werkt niet
INSERT INTO rental values (2002,367,296,479,331,null,'2016-12-4 11:31:56.150',null,null,null,null)
,(2003,467,292,476,331,null,'2016-12-4 11:32:56.150',null,null,null,null)

CREATE TRIGGER trgBikeAlreadyRented
ON Rental
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0 RETURN 
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN
			IF EXISTS (SELECT 1 
			FROM rental r
			INNER JOIN [user] u 
			ON r.userid = u.userid
			INNER JOIN Inserted i 
			ON u.userid = i.userid
			WHERE r.ENDTIME IS NULL
			AND R.rentalid != i.rentalid)		
			BEGIN
				;THROW 50000, 'Deze user huurt al een fiets.', 1
			END
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO


/*===============================================================================================================================================*/
/*==========================Constraint 10========================*/
--Als de gebruiker bij een station komt waar geen lege bike posts zijn krijgt hij 15 minuten extra gratis fietstijd
--Onderdeel van een sp
if not exists(select *
from station s 
inner join post p 
on s.stationid = p.stationid
inner join inserted i 
on s.stationid = i.stationid
and p.locked = 0)
BEGIN
;THROW 50000,'In dit station is op dit moment geen plaats voor uw fiets, u hebt 15 minuten extra tijd gekregen om de fiets naar een ander Vélib'' station te sturen',1
END

/*===============================================================================================================================================*/
/*==========================Constraint 11========================*/
--Een post kan alleen gelocked worden als er een bike in zit

--Dit werkt wel want de post is gelocked wanneer er een bike in zit
BEGIN TRAN
INSERT INTO post VALUES (1000,677,1590,1)

ROLLBACK

--Dit werkt niet want de post is gelocked maar er zit geen bike in
INSERT INTO post VALUES (1000,677,null,1)

--Dit werkt niet want de post is niet gelocked terwijl er wel een bike in zit
INSERT INTO post VALUES (1000,677,1590,0)

ALTER TABLE post ADD CONSTRAINT ck_checkPost CHECK (bikeid IS NOT NULL AND locked = 1 OR bikeid IS NULL and locked = 0)

