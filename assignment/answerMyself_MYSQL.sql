
-- DB 생성 및 전환 
CREATE DATABASE DatamotionMovieDatabase;
use DatamotionMovieDatabase;
show databases;
show tables;

DROP database DatamotionMovieDatabase;

SELECT * FROM movie;
SELECT * FROM movie_original;
SELECT * FROM moviearticle;
SELECT * FROM moviegenre;
SELECT * FROM moviesonscreen;
SELECT * FROM movietrivia;
SELECT * FROM person;
SELECT * FROM appear;
SELECT * FROM award;
SELECT * FROM awardinvolve;
SELECT * FROM awardyear;
SELECT * FROM characters;
SELECT * FROM genre;
SELECT * FROM grade;
SELECT * FROM gradeinkorea;
SELECT * FROM kindofsource;
SELECT * FROM majorrole;
SELECT * FROM originalsource;
SELECT * FROM originalsource_person;
SELECT * FROM persontrivia;
SELECT * FROM rating;
SELECT * FROM ratingsource;
SELECT * FROM role;
SELECT * FROM sector;
SELECT * FROM series;
SELECT * FROM series_movie;
SELECT * FROM sysdiagrams;
SELECT * FROM tempname;
SELECT * FROM trivia;
SELECT * FROM winning;

desc person;
desc movie;
desc appear;
desc award;
desc role;


-- 1.영화 '퍼스트 맨’의 제작 연도, 영문 제목, 러닝 타임, 플롯을 출력하세요
SELECT ReleaseYear, Title, RunningTime, Plot
FROM movie
WHERE KoreanTitle = "퍼스트 맨";

-- 2.2003년에 개봉한 영화의 한글 제목과 영문 제목을 출력하세요
SELECT KoreanTitle, Title
FROM movie
WHERE ReleaseYear = 2003;

-- 3.영화 '글래디에이터’의 작곡가(Composer)의 한글 이름을 출력하세요
-- 내가 푼 방식
SELECT KoreanName
FROM (SELECT A.PersonID
	  FROM movie M
	  INNER JOIN appear A ON M.MovieId = A.MovieId 
	  WHERE M.KoreanTitle = "글래디에이터" AND A.RoleID = 27) AS J
INNER JOIN person AS P
ON J.PersonID = P.PersonID;

SELECT P.KoreanName
FROM person P
INNER JOIN appear A ON P.PersonID = A.PersonID
INNER JOIN movie M ON A.MovieID = M.MovieID
WHERE M.KoreanTitle = "글래디에이터" AND A.RoleID = 27;

-- 4.영화 '매트릭스' 의 감독이 몇 명인지 출력하세요
SELECT *
FROM movie M
INNER JOIN appear A ON M.MovieID = A.MovieID
WHERE M.KoreanTitle = "매트릭스" AND A.RoleID = 2;

-- 5.감독이 2명 이상인 영화의 정보를 다음 형식으로 출력하세요(하나의 컬럼) 
--   -> 한글영화제목(영문 영화제목) - 개봉연도
-- 내가 푼 방식
SELECT CONCAT(KoreanTitle, '(', Title, ') - ', ReleaseYear) AS 영화정보
FROM (SELECT M.MovieId, M.KoreanTitle, M.Title, M.ReleaseYear
	  FROM movie M
      INNER JOIN appear A ON M.MovieID = A.MovieID 
	  WHERE A.RoleID = 2 AND M.KoreanTitle IS NOT NULL) AS S
GROUP BY MovieId
HAVING COUNT(*) >= 2
ORDER BY ReleaseYear DESC;

SELECT CONCAT(M.KoreanTitle, '(', M.Title, ') - ', M.ReleaseYear) AS 영화정보
FROM movie AS M
INNER JOIN appear A ON M.MovieID = A.MovieID
WHERE A.RoleID = 2 AND M.KoreanTitle IS NOT NULL
GROUP BY M.MovieID, M.KoreanTitle, M.Title, M.ReleaseYear
HAVING COUNT(*) >= 2
ORDER BY M.ReleaseYear DESC;


-- 6.'한스 짐머’가 참여한 영화 중 아카데미를 수상한 영화의 한글 제목을 출력하세요
-- 내가 푼 방식
SELECT S.KoreanTitle
FROM (SELECT A.AppearID, M.MovieID, M.KoreanTitle
	  FROM movie M
	  INNER JOIN appear A ON M.MovieID = A.MovieID 
	  WHERE A.PersonID = 121) AS S
INNER JOIN awardinvolve AS Award
ON S.AppearID = Award.AppearID;

SELECT M.KoreanTitle
FROM movie M
INNER JOIN appear A ON M.MovieID = A.MovieID
INNER JOIN awardinvolve AW ON A.AppearID = AW.AppearID
WHERE A.PersonID = 121;


-- 7.감독이 '제임스 카메론’이고 '아놀드 슈워제네거’가 출연한 영화를 다음 형식으로 출력하세요(하나의 컬럼).
--   -> 한글영화제목(영문 영화제목) - 개봉연도
-- 내가 푼 방식
SELECT CONCAT(A.KoreanTitle, '(', A.Title, ') - ', A.ReleaseYear) AS 영화정보
FROM (SELECT *
	  FROM appear
	  NATURAL JOIN movie
	  NATURAL JOIN person
	  WHERE RoleID = 2 AND KoreanName = '제임스 카메론') AS A
INNER JOIN (SELECT *
			FROM appear
			NATURAL JOIN movie
			NATURAL JOIN person
			WHERE RoleID = 6 AND KoreanName = '아놀드 슈워제네거') AS B
ON A.MovieID = B.MovieID
ORDER BY A.ReleaseYear DESC;

SELECT CONCAT(M.KoreanTitle, '(', M.Title, ') - ', M.ReleaseYear) AS 영화정보
FROM movie M
INNER JOIN appear A ON M.MovieID = A.MovieID
INNER JOIN person P_A ON A.PersonID = P_A.PersonID AND P_A.KoreanName = '제임스 카메론' AND A.RoleID = 2
INNER JOIN appear B ON M.MovieID = B.MovieID
INNER JOIN person P_B ON B.PersonID = P_B.PersonID AND P_B.KoreanName = '아놀드 슈워제네거' AND B.RoleID = 6
ORDER BY M.ReleaseYear DESC;


-- 8.상영시간이 100분 이상인 영화 중 레오나르도 디카프리오가 출연한 한글 제목과 개봉 연도를 출력하세요.
SELECT M.KoreanTitle, M.ReleaseYear
FROM movie M
INNER JOIN appear A ON M.MovieID = A.MovieID
INNER JOIN person P ON A.PersonID = P.PersonID AND P.KoreanName = '레오나르도 디카프리오' AND A.RoleID = 6 AND M.RunningTime >= 100
ORDER BY M.ReleaseYear DESC;


-- 9.청소년 관람불가 등급의 영화 중 가장 많은 수익을 얻은 영화의 한글 제목, 원제(영어제목), 개봉연도, 세계흥행 금액을 출력하세요
SELECT M.KoreanTitle, M.Title, M.ReleaseYear, (M.BoxOfficeWWGross + M.BoxOfficeUSGross) AS TotalPrice
FROM movie M
INNER JOIN gradeinkorea G
ON M.GradeInKoreaID = G.GradeInKoreaID
ORDER BY TotalPrice DESC
LIMIT 1;


-- 10.1999년 이전에 제작된 영화의 수익 평균을 고르시오. 출력 형식은 달러 통화 형식이어야 합니다.
SELECT CONCAT('$', FORMAT(AVG(BoxOfficeWWGross + BoxOfficeUSGross), 2)) AS AveragePrice
FROM movie
WHERE ReleaseYear < 1999;


-- 11.가장 많은 제작비가 투입된 영화를 다음 형식으로 출력하세요.
--    -> 한글영화제목(영문 영화제목) - 개봉연도
SELECT CONCAT(KoreanTitle, '(', Title, ') - ', ReleaseYear) AS 영화정보
FROM movie
ORDER BY Budget DESC
LIMIT 1;


-- 12.감독한 영화의 제작비 총합이 가장 높은 감독을 다음 형식으로 출력하세요.
--    -> 한글 이름(영문 이름) - 나이
SELECT CONCAT(P.KoreanName, '(', P.Name, ') - ', TIMESTAMPDIFF(YEAR, P.BirthDate, CURDATE())) AS 감독정보
FROM movie M
INNER JOIN appear A ON M.MovieID = A.MovieID AND A.RoleId = 2
INNER JOIN person P ON A.PersonID = P.PersonID
GROUP BY A.PersonID
ORDER BY SUM(M.Budget) DESC
LIMIT 1;


-- 13.출연한 영화의 모든 수익을 합하여, 총 수입이 가장 많은 배우의 이름과 출생 연도를 출력하세요.(두 개의 컬럼)
SELECT P.Name, P.BirthDate
FROM movie M
INNER JOIN appear A ON M.MovieID = A.MovieID AND A.RoleId = 6
INNER JOIN person P ON A.PersonID = P.PersonID
GROUP BY A.PersonID, P.Name, P.BirthDate
ORDER BY SUM(M.BoxOfficeWWGross + M.BoxOfficeUSGross) DESC
LIMIT 1;


-- 14.제작비가 가장 적게 투입된 영화의 한글 제목과 수익을 출력하세요. 제작비가 0인 영화는 제외하며,
SELECT CONCAT('$', FORMAT(AVG(BoxOfficeUSGross), 2)) AS AverageProfit
FROM movie
WHERE Budget <= 5000000;

-- 15.제작비가 5000만 달러 이하인 영화의 미국내 평균 수익을 출력하세요. 출력 형식은 통화 형식이어야 합니다.


-- 16.액션 장르 영화의 평균 수익을 출력하세요. 출력 형식은 통화 형식이어야 합니다.
-- 내가 푼 방식
SELECT CONCAT('$', FORMAT(AVG(BoxOfficeWWGross + BoxOfficeUSGross), 2)) AS AveragePrice
FROM movie M
INNER JOIN (SELECT G.GenreID, MG.MovieID, G.GenreName, G.GenreKorName
			FROM moviegenre MG
			INNER JOIN genre G ON G.GenreID = MG.GenreID AND G.GenreKorName = '액션') AS JG
ON M.MovieID = JG.MovieID;

SELECT CONCAT('$', FORMAT(AVG(BoxOfficeWWGross + BoxOfficeUSGross), 2)) AS AveragePrice
FROM moviegenre MG
INNER JOIN genre G ON G.GenreID = MG.GenreID 
INNER JOIN movie M ON MG.MovieID = M.MovieID
WHERE G.GenreKorName = '액션';


-- 17.장르가 드라마, 전쟁인 영화의 제목을 아래 형식으로 출력하세요.
--    -> 한글영화제목(영문 영화제목) - 개봉연도
SELECT CONCAT(M.KoreanTitle, '(', M.Title, ') - ', M.ReleaseYear) AS 영화정보
FROM moviegenre MG
INNER JOIN genre G ON MG.GenreID = G.GenreID 
INNER JOIN movie M ON MG.MovieID = M.MovieID
WHERE G.GenreKorName = '드라마' OR G.GenreKorName = '전쟁'
ORDER BY M.ReleaseYear DESC;


-- 18.톰 행크스가 출연한 영화 중 상영 시간이 가장 긴 영화의 제목, 한글제목, 개봉연도를 출력하세요.(세 개의 컬럼)
SELECT M.Title, M.KoreanTitle, M.ReleaseYear
FROM movie M
INNER JOIN appear A ON M.MovieID = A.MovieID
INNER JOIN person P ON A.PersonID = P.PersonID
WHERE P.KoreanName = '톰 행크스'
ORDER BY M.RunningTime DESC
LIMIT 1;


-- 19.아카데미 남우주연상을 가장 많이 수상한 배우의 한글 이름과 영문 이름을 출력하세요.(두 개의 컬럼))
SELECT * FROM award;
SELECT * FROM awardinvolve;
SELECT * FROM appear;
SELECT * FROM person;
SELECT * FROM sector;

SELECT P.KoreanName, P.Name
FROM awardinvolve AI
INNER JOIN sector S ON AI.SectorID = S.SectorID AND S.SectorKorName = '남우주연상'
INNER JOIN appear A ON AI.AppearID = A.AppearID AND A.RoleID = '6'
INNER JOIN person P ON A.PersonID = P.PersonID
GROUP BY P.PersonID
ORDER BY COUNT(*) DESC
LIMIT 1;


-- 20.아카데미상을 가장 많이 수상한 배우의 한글 이름과 영문 이름을 출력하세요.('수상자 없음’이 이름인 영화인은 제외합니다)
SELECT P.KoreanName, P.Name
FROM awardinvolve AI
INNER JOIN sector S ON AI.SectorID = S.SectorID
INNER JOIN appear A ON AI.AppearID = A.AppearID AND A.RoleID IN (6, 7)
INNER JOIN person P ON A.PersonID = P.PersonID
GROUP BY P.PersonID
ORDER BY COUNT(*) DESC
LIMIT 1 OFFSET 1;


-- 21.아카데미 남우주연상을 2번 이상 수상한 배우의 한글 이름과 영문 이름을 출력하세요.
SELECT P.KoreanName, P.Name
FROM awardinvolve AI
INNER JOIN sector S ON AI.SectorID = S.SectorID AND S.SectorKorName = '남우주연상'
INNER JOIN appear A ON AI.AppearID = A.AppearID AND A.RoleID = '6'
INNER JOIN person P ON A.PersonID = P.PersonID
GROUP BY P.PersonID
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC;


-- 22.아카데미상을 가장 많이 수상한 사람의 한글 이름과 영문 이름을 출력하세요.
SELECT P.KoreanName, P.Name
FROM awardinvolve AI
INNER JOIN sector S ON AI.SectorID = S.SectorID
INNER JOIN appear A ON AI.AppearID = A.AppearID
INNER JOIN person P ON A.PersonID = P.PersonID
GROUP BY P.PersonID
ORDER BY COUNT(*) DESC
LIMIT 1 OFFSET 1;


-- 23.아카데미상에 가장 많이 노미네이트 된 영화의 한글 제목, 영문 제목, 개봉 연도를 출력하세요. (세 개의 컬럼)
SELECT M.KoreanTitle, M.title, M.ReleaseYear
FROM awardinvolve AI
INNER JOIN winning W ON AI.WinningID = W.WinningID AND W.WinningID = 1
INNER JOIN appear A ON AI.AppearID = A.AppearID
INNER JOIN movie M ON A.MovieID = M.MovieID
GROUP BY M.MovieID
ORDER BY COUNT(*) DESC
LIMIT 1;


-- 24.가장 많은 영화에 출연한 여배우의 한글 이름과 영문 이름을 출력하세요.
SELECT P.KoreanName, P.Name
FROM appear A
INNER JOIN movie M ON A.MovieID = M.MovieID
INNER JOIN person P ON A.PersonID = P.PersonID AND A.RoleID = 7
GROUP BY A.PersonID
ORDER BY COUNT(M.MovieID) DESC
LIMIT 1;


-- 25.아카데미상을 가장 많이 수상한 영화를 아래 형식으로 출력하세요.
--     -> <한글영화제목>(<영문 영화제목>) - <개봉연도>
SELECT CONCAT('<', M.KoreanTitle, '>','(<', M.Title, '>) - <', M.ReleaseYear, '>') AS 영화정보
FROM awardinvolve AI
INNER JOIN appear A ON AI.AppearID = A.AppearID
INNER JOIN movie M ON A.MovieID = M.MovieID
GROUP BY M.MovieID
ORDER BY COUNT(M.MovieID) DESC
LIMIT 1;


-- 26.수익이 가장 높은 영화 TOP 10을 아래 형식으로 출력하세요. 수익으로 내림차순 정렬되어야 합니다.
--    -> <한글영화제목>(<영문 영화제목>) - <개봉연도>
SELECT CONCAT('<', KoreanTitle, '>','(<', Title, '>) - <', ReleaseYear, '>') AS 영화정보
FROM movie
ORDER BY (BoxOfficeWWGross+BoxOfficeUSGross) DESC
LIMIT 10;


-- 27.수익이 10억불 이상인 영화중 제작비가 1억불 이하인 영화를 아래 형식으로 출력하세요. 제작비로 오름차순 정렬 되어야 합니다.
--    -> <한글영화제목>(<영문 영화제목>) - <개봉연도>
SELECT CONCAT('<', KoreanTitle, '>','(<', Title, '>) - <', ReleaseYear, '>') AS 영화정보
FROM movie
WHERE (BoxOfficeWWGross + BoxOfficeUSGross) >= 1000000000 AND Budget <= 100000000
ORDER BY Budget;


-- 28.전쟁 영화를 가장 많이 감독한 사람의 한글 이름과 영문 이름을 출력하세요. (두 개의 컬럼)
SELECT P.KoreanName, P.Name
FROM moviegenre MG
INNER JOIN genre G ON MG.GenreID = G.GenreID AND G.GenreKorName = '전쟁'
INNER JOIN movie M ON MG.MovieID = M.MovieID
INNER JOIN appear A ON M.MovieID = A.MovieID AND A.RoleID = 2
INNER JOIN person P ON A.PersonID = P.PersonID
GROUP BY P.PersonID
ORDER BY COUNT(M.MovieID) DESC
LIMIT 1;


-- 29.드라마 장르의 영화에 가장 많이 출연한 사람의 한글 이름과 영문 이름을 출력하세요. (두 개의 컬럼)
SELECT P.KoreanName, P.Name
FROM moviegenre MG
INNER JOIN genre G ON MG.GenreID = G.GenreID AND G.GenreKorName = '드라마'
INNER JOIN movie M ON MG.MovieID = M.MovieID
INNER JOIN appear A ON M.MovieID = A.MovieID AND A.RoleID IN (6, 7)
INNER JOIN person P ON A.PersonID = P.PersonID
GROUP BY P.PersonID
ORDER BY COUNT(M.MovieID) DESC
LIMIT 1;


-- 30.드라마 장르에 출연했지만 호러 영화에 한번도 출연하지 않은 남배우의 한글 이름과 영문 이름을 출력하세요.(두 개의 컬럼)
SELECT P.KoreanName, P.Name
FROM moviegenre MG
INNER JOIN genre G ON MG.GenreID = G.GenreID AND G.GenreKorName = '드라마'
INNER JOIN movie M ON MG.MovieID = M.MovieID
INNER JOIN appear A ON M.MovieID = A.MovieID AND A.RoleID = 6
INNER JOIN person P ON A.PersonID = P.PersonID
WHERE P.PersonID NOT IN (
    SELECT A2.PersonID
    FROM appear A2
    INNER JOIN movie M2 ON A2.MovieID = M2.MovieID  AND A.RoleID = 6
    INNER JOIN moviegenre MG2 ON M2.MovieID = MG2.MovieID
    INNER JOIN genre G2 ON MG2.GenreID = G2.GenreID AND G2.GenreKorName = '호러'
);


-- 31.아카데미 영화제가 가장 많이 열린 장소는 어디인가요?
SELECT Location
FROM awardyear
GROUP BY Location
ORDER BY COUNT(Location) DESC
LIMIT 1;


-- 32.첫 번째 아카데미 영화제가 열린지 올해 기준으로 몇년이 지났나요?
SELECT YEAR(CURDATE()) - YEAR(DATE) AS Since
FROM awardyear
ORDER BY DATE
LIMIT 1;


-- 33.SF 장르의 영화 중 아카데미 영화제 후보에 가장 많이 오른 영화의 한글 제목을 구하세요.
SELECT M.KoreanTitle
FROM awardinvolve AI
INNER JOIN winning W ON AI.WinningID = W.WinningID AND W.WinOrNot = 'Nominated'
INNER JOIN appear A ON AI.AppearID = A.AppearID
INNER JOIN movie M ON A.MovieID = M.MovieID
INNER JOIN moviegenre MG ON M.MovieID = MG.MovieID
INNER JOIN genre G ON MG.GenreID = G.GenreID AND G.GenreName = 'Sci-Fi'
GROUP BY M.MovieID
ORDER BY COUNT(AI.AppearID) DESC
LIMIT 1;


-- 34.드라마 장르의 영화의 아카데미 영화제 작품상 수상 비율을 구하세요.
SELECT (COUNT(DISTINCT CASE WHEN G.GenreKorName = '드라마' THEN M.MovieID 
							END) / COUNT(DISTINCT M.MovieID)) * 100 AS DramaAwardPercentage
FROM awardinvolve AI
INNER JOIN sector S ON AI.SectorID = S.SectorID AND S.SectorKorName = '작품상'
INNER JOIN appear A ON AI.AppearID = A.AppearID
INNER JOIN movie M ON A.MovieID = M.MovieID
INNER JOIN moviegenre MG ON M.MovieID = MG.MovieID
INNER JOIN genre G ON MG.GenreID = G.GenreID;


-- 35.'휴 잭맨’이 출연한 영화의 제작비 대비 수익율을 출력하세요.
SELECT KoreanTitle, Title, ((BoxOfficeWWGross + BoxOfficeUSGross) / Budget) * 100 AS ProfitMargin
FROM appear A
INNER JOIN person P ON A.PersonID = P.PersonID AND P.KoreanName = '휴 잭맨'
INNER JOIN movie M ON A.MovieID = M.MovieID
WHERE Budget > 0
ORDER BY ProfitMargin DESC;