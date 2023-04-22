use Analysis;

select * from Imdb;

select * from Imdb
where Budget_cr is not null and Total_Collection_Cr is not null

---deleting Rows where Budget and Total_Collection Is Null

delete from Imdb
where  Budget_cr is null or Total_Collection_Cr is null

---Rouding Imdb Column Into 2 Decimal Value
select Round(Imdb,2) from Imdb

---Updating Imdb Column
update Imdb
set IMDb=Round(Imdb,2);

---Renaming Imdb Colum Into Imdb_rating For Better Understand
EXEC sp_rename 'Imdb.IMDb', 'Imdb_rating', 'COLUMN';

---Adding Genre1 Column Into Table
alter table Imdb
add Genre1 varchar(50);

---Adding Genre2 Column Into Table
alter table Imdb
add Genre2 varchar(50);

---Adding Genre3 Column Into Table
alter table Imdb
add Genre3 varchar(50);

select * from Imdb

---Spliting Genre Column Into Three Columns as Genre1,Genre2,Genre3
SELECT 
  CASE 
    WHEN CHARINDEX(',', Genre) > 0 THEN SUBSTRING(Genre, 1, CHARINDEX(',', Genre)-1)
    ELSE Genre
  END AS Genre1,
  CASE 
    WHEN CHARINDEX(',', Genre) > 0 AND CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1) > 0 THEN SUBSTRING(Genre, CHARINDEX(',', Genre)+1, CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1)-CHARINDEX(',', Genre)-1)
    WHEN CHARINDEX(',', Genre) > 0 THEN SUBSTRING(Genre, CHARINDEX(',', Genre)+1, LEN(Genre)-CHARINDEX(',', Genre))
    ELSE Null
  END AS Genre2,
  CASE 
    WHEN CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1) > 0 THEN SUBSTRING(Genre, CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1)+1, LEN(Genre)-CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1))
    WHEN CHARINDEX(',', Genre) > 0 THEN NULL
    ELSE Null
  END AS Genre3
FROM Imdb

select Genre From Imdb

---Updating Into Table
update Imdb
set Genre1 = (SELECT 
  CASE 
    WHEN CHARINDEX(',', Genre) > 0 THEN SUBSTRING(Genre, 1, CHARINDEX(',', Genre)-1)
    ELSE Genre
  END)

Update Imdb
set Genre2=( CASE 
    WHEN CHARINDEX(',', Genre) > 0 AND CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1) > 0 THEN SUBSTRING(Genre, CHARINDEX(',', Genre)+1, CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1)-CHARINDEX(',', Genre)-1)
    WHEN CHARINDEX(',', Genre) > 0 THEN SUBSTRING(Genre, CHARINDEX(',', Genre)+1, LEN(Genre)-CHARINDEX(',', Genre))
    ELSE Null
  END )

Update Imdb
set Genre3=(   CASE 
    WHEN CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1) > 0 THEN SUBSTRING(Genre, CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1)+1, LEN(Genre)-CHARINDEX(',', Genre, CHARINDEX(',', Genre)+1))
    WHEN CHARINDEX(',', Genre) > 0 THEN NULL
    ELSE Null
  END )

---Adding New Duration_IN_Hrs Column Into table
alter table Imdb
add Duration_In_Hrs Float;

---Spliting Movie_Duration Column To Get Number Values
select Substring(Movie_duration,1,charindex('min',Movie_duration)-1) from Imdb

---Updating Into Table
update Imdb
set Duration_In_Hrs =Substring(Movie_duration,1,charindex('min',Movie_duration)-1) ;

---Converting Column Minutes Values Into Hrs 
select Round(Duration_In_Hrs/60,2) from Imdb

---Updating Into Table
update Imdb
set Duration_In_Hrs =Round(Duration_In_Hrs/60,2);

select * from Imdb


