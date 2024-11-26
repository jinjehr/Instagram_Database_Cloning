--  오래된 유저 5명 찾기
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

-- 가장 회원가입을 많이한 요일 찾기
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS most_registered_day
    FROM users
GROUP BY 1
ORDER BY 2 DESC;

-- 게시물을 올리지 않은 비활성 유적 찾기
SELECT 
	U.id AS number,
    U.username AS USER_WITH_NO_PHOTOS
FROM
    users AS U
        LEFT JOIN
    photos AS P ON P.user_id = U.id
    WHERE P.image_url IS NULL;

-- 좋아요가 가장 많은 게시물과 함께 그 정보찾기
SELECT 
    U.id AS number,
    U.username,
    P.id AS photo_id,
    P.image_url,
    COUNT(*) AS total_likes
FROM
    photos AS P
        INNER JOIN
    likes AS L ON L.photo_id = P.id
        INNER JOIN
    users AS U ON P.user_id = U.id
GROUP BY P.id
ORDER BY 5 DESC
LIMIT 10;

-- 모든 유저에 대한 평균 게시물 수 구하기
SELECT (SELECT COUNT(*) 
        FROM   photos) / (SELECT COUNT(*) 
                          FROM   users) AS avg_of_all_photos;
                          
-- 모든 유저에 대한 평균 좋아요 수 구하기
SELECT (SELECT COUNT(*) 
        FROM   likes) / (SELECT COUNT(*) 
                          FROM   users) AS avg_of_all_likes;

-- 모든 유저에 대한 평균 댓글 수 구하기                          
SELECT (SELECT COUNT(*) 
        FROM   comments) / (SELECT COUNT(*) 
                          FROM   users) AS avg_of_all_comments;

-- 상위 검색된 10개의 해시태그 찾기
SELECT T.tag_name, 
       COUNT(*) AS the_most_famous_tags 
FROM   photo_tags AS PT
       JOIN tags AS T
         ON PT.tag_id = T.id 
GROUP  BY T.id 
ORDER  BY the_most_famous_tags  DESC 
LIMIT  10;

-- 게시물은 없지만 좋아요와 댓글은 있는 계정찾기
SELECT username, 
       COUNT(*) AS num_likes 
FROM   users AS U
       INNER JOIN likes AS L
               ON U.id = L.user_id 
GROUP  BY L.user_id 
HAVING num_likes = (SELECT COUNT(*) 
                    FROM   photos);
