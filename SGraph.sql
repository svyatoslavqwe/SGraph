USE MASTER
GO
DROP DATABASE IF EXISTS SGraph
GO
CREATE DATABASE SGraph
GO
USE SGraph
GO

-- Создание таблицы "Автор" (Author)
CREATE TABLE Author (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    LastName NVARCHAR(50),
    Affiliation NVARCHAR(100)
) AS NODE;

-- Создание таблицы "Научная статья" (ScientificArticle)
CREATE TABLE ScientificArticle (
    ID INT PRIMARY KEY,
    Name NVARCHAR(255),
    PublicationDate DATE,
    Abstract TEXT
) AS NODE;

-- Создание таблицы "Ключевое слово" (Keyword)
CREATE TABLE Keyword (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50)
) AS NODE;

-- Заполнение таблицы Author данными
INSERT INTO Author (ID, Name, LastName, Affiliation) VALUES
(1, 'John', 'Doe', 'University of Science'),
(2, 'Alice', 'Smith', 'Research Institute'),
(3, 'Michael', 'Johnson', 'Tech Academy'),
(4, 'Emily', 'Brown', 'Science Foundation'),
(5, 'Daniel', 'Wilson', 'Advanced Labs'),
(6, 'Sophia', 'Lee', 'Engineering College'),
(7, 'David', 'Anderson', 'Medical Center'),
(8, 'Olivia', 'Martinez', 'Institute of Technology'),
(9, 'Ethan', 'Taylor', 'Academic Union'),
(10, 'Emma', 'Garcia', 'Research Consortium');

-- Заполнение таблицы ScientificArticle данными
INSERT INTO ScientificArticle (ID, Name, PublicationDate, Abstract) VALUES
(1, 'Study of Neural Networks', '2023-05-10', 'This paper explores the application of neural networks in pattern recognition.'),
(2, 'Advances in Quantum Computing', '2023-08-20', 'The article discusses recent developments in the field of quantum computing and its potential applications.'),
(3, 'Gene Editing Techniques', '2023-06-15', 'A review of various gene editing technologies and their implications for genetic research.'),
(4, 'Climate Change Impact on Biodiversity', '2023-09-30', 'An analysis of the effects of climate change on global biodiversity and ecosystem stability.'),
(5, 'Artificial Intelligence in Medicine', '2023-07-25', 'This study investigates the use of artificial intelligence in medical diagnosis and treatment planning.'),
(6, 'Renewable Energy Technologies', '2023-10-05', 'The paper explores various renewable energy sources and their potential to replace fossil fuels.'),
(7, 'Robotics in Manufacturing', '2023-08-10', 'An overview of robotic applications in modern manufacturing processes.'),
(8, 'Bioinformatics Approaches in Drug Discovery', '2023-06-30', 'A review of bioinformatics tools and methods for drug discovery and development.'),
(9, 'Space Exploration Technologies', '2023-11-15', 'The article discusses recent advancements in space exploration technologies and future missions.'),
(10, 'Cybersecurity Challenges in the Digital Age', '2023-07-05', 'An analysis of emerging cybersecurity threats and strategies to mitigate risks.');

-- Заполнение таблицы Keyword данными
INSERT INTO Keyword (ID, Name) VALUES
(1, 'Neural Networks'),
(2, 'Quantum Computing'),
(3, 'Gene Editing'),
(4, 'Climate Change'),
(5, 'Artificial Intelligence'),
(6, 'Renewable Energy'),
(7, 'Robotics'),
(8, 'Bioinformatics'),
(9, 'Space Exploration'),
(10, 'Cybersecurity');


CREATE TABLE Writes AS EDGE
CREATE TABLE Includes AS EDGE
CREATE TABLE Works AS EDGE

INSERT INTO Works ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Author WHERE id = 1),
 (SELECT $node_id FROM Author WHERE id = 2)),
 ((SELECT $node_id FROM Author WHERE id = 10),
 (SELECT $node_id FROM Author WHERE id = 5)),
 ((SELECT $node_id FROM Author WHERE id = 2),
 (SELECT $node_id FROM Author WHERE id = 9)),
 ((SELECT $node_id FROM Author WHERE id = 3),
 (SELECT $node_id FROM Author WHERE id = 1)),
 ((SELECT $node_id FROM Author WHERE id = 3),
 (SELECT $node_id FROM Author WHERE id = 6)),
 ((SELECT $node_id FROM Author WHERE id = 4),
 (SELECT $node_id FROM Author WHERE id = 2)),
 ((SELECT $node_id FROM Author WHERE id = 5),
 (SELECT $node_id FROM Author WHERE id = 4)),
 ((SELECT $node_id FROM Author WHERE id = 6),
 (SELECT $node_id FROM Author WHERE id = 7)),
 ((SELECT $node_id FROM Author WHERE id = 6),
 (SELECT $node_id FROM Author WHERE id = 8)),
 ((SELECT $node_id FROM Author WHERE id = 8),
 (SELECT $node_id FROM Author WHERE id = 3));

INSERT INTO Writes ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Author WHERE ID = 1),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 1)),
 ((SELECT $node_id FROM Author WHERE ID = 5),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 1)),
 ((SELECT $node_id FROM Author WHERE ID = 8),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 1)),
 ((SELECT $node_id FROM Author WHERE ID = 2),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 2)),
 ((SELECT $node_id FROM Author WHERE ID = 3),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 3)),
 ((SELECT $node_id FROM Author WHERE ID = 4),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 3)),
 ((SELECT $node_id FROM Author WHERE ID = 6),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 4)),
 ((SELECT $node_id FROM Author WHERE ID = 7),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 4)),
 ((SELECT $node_id FROM Author WHERE ID = 1),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 9)),
 ((SELECT $node_id FROM Author WHERE ID = 9),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 4)),
 ((SELECT $node_id FROM Author WHERE ID = 10),
 (SELECT $node_id FROM ScientificArticle WHERE ID = 9));


INSERT INTO Includes ($from_id, $to_id)
VALUES ((SELECT $node_id FROM ScientificArticle WHERE ID = 1),
 (SELECT $node_id FROM Keyword WHERE ID = 6)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 5),
 (SELECT $node_id FROM Keyword WHERE ID = 1)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 8),
 (SELECT $node_id FROM Keyword WHERE ID = 7)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 2),
 (SELECT $node_id FROM Keyword WHERE ID = 2)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 3),
 (SELECT $node_id FROM Keyword WHERE ID = 5)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 4),
 (SELECT $node_id FROM Keyword WHERE ID = 3)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 6),
 (SELECT $node_id FROM Keyword WHERE ID = 4)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 7),
 (SELECT $node_id FROM Keyword WHERE ID = 2)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 1),
 (SELECT $node_id FROM Keyword WHERE ID = 9)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 9),
 (SELECT $node_id FROM Keyword WHERE ID = 8)),
 ((SELECT $node_id FROM ScientificArticle WHERE ID = 10),
 (SELECT $node_id FROM Keyword WHERE ID = 9));

 SELECT A1.name, A2.name
FROM Author AS A1
	, Works AS w
	, Author AS A2
WHERE MATCH(A1-(w)->A2)
	AND A1.name = 'Michael';

SELECT a.name, s.name
FROM Author AS a
	, Writes AS w
	, ScientificArticle AS s
WHERE MATCH(a-(w)->s)
AND a.name = 'John';

SELECT k.name, s.name
FROM Keyword AS k
	, Includes AS i
	, ScientificArticle AS s
WHERE MATCH(s-(i)->k)
AND k.name = 'Quantum Computing';

SELECT a.name, s.name
FROM Author AS a
	, Writes AS w
	, ScientificArticle AS s
WHERE MATCH(a-(w)->s)
AND s.name = 'Study of Neural Networks';

SELECT k.name, s.name
FROM Keyword AS k
	, Includes AS i
	, ScientificArticle AS s
WHERE MATCH(s-(i)->k)
AND s.name = 'Study of Neural Networks';

SELECT A1.name
	, STRING_AGG(A2.name, '->') WITHIN GROUP (GRAPH PATH)
FROM Author AS A1
	, Works FOR PATH AS w
	, Author FOR PATH AS A2
WHERE MATCH(SHORTEST_PATH(A1(-(w)->A2)+))
	AND A1.name = 'Michael';

	
SELECT A1.name
	, STRING_AGG(A2.name, '->') WITHIN GROUP (GRAPH PATH)
FROM Author AS A1
	, Works FOR PATH AS w
	, Author FOR PATH AS A2
WHERE MATCH(SHORTEST_PATH(A1(-(w)->A2){1,3}))
	AND A1.name = 'Sophia';

SELECT A1.ID AS IdFirst
	, A1.name AS First
	, CONCAT(N'author (', A1.id, ')') AS [First image name]
	, A2.ID AS IdSecond
	, A2.name AS Second
	, CONCAT(N'author (', A2.id, ')') AS [Second image name]
FROM Author AS A1
	, Works AS w
	, Author AS A2
WHERE MATCH(A1-(w)->A2);

SELECT A.ID AS IdFirst
	, A.name AS First
	, CONCAT(N'author (', A.id, ')') AS [First image name]
	, Ac.ID AS IdSecond
	, Ac.name AS Second
	, CONCAT(N'article (', Ac.id, ')') AS [Second image name]
FROM Author AS A
	, Writes AS w
	, ScientificArticle AS Ac
WHERE MATCH(A-(w)->Ac);

SELECT k.ID AS IdFirst
	, k.name AS First
	, CONCAT(N'keyword (', k.id, ')') AS [First image name]
	, s.ID AS IdSecond
	, s.name AS Second
	, CONCAT(N'article (', s.id, ')') AS [Second image name]
FROM Keyword AS k
	, Includes AS i
	, ScientificArticle AS s
WHERE MATCH(s-(i)->k);

select @@servername