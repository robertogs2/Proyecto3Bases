USE BASESTEC;

INSERT INTO ResearchProject
(Budget, StartTime, "Description")
VALUES
(100000, GETDATE(), 'Investigation on new zombie plants.');

INSERT INTO ResearchProjectXEmployee
(fk_idResearchProject, fk_idEmployee, ColabStartTime)
VALUES
(1,3,GETDATE());

INSERT INTO ResearchProjectXEmployee
(fk_idResearchProject, fk_idEmployee, ColabStartTime)
VALUES
(1,7,GETDATE());

INSERT INTO ResearchProjectXEmployee
(fk_idResearchProject, fk_idEmployee, ColabStartTime)
VALUES
(1,11,GETDATE());





INSERT INTO ResearchProject
(Budget, StartTime, "Description")
VALUES
(50000, GETDATE(), 'Interest in new behavior of squirels eating lions.');

INSERT INTO ResearchProjectXEmployee
(fk_idResearchProject, fk_idEmployee, ColabStartTime)
VALUES
(2,7,GETDATE());

INSERT INTO ResearchProjectXEmployee
(fk_idResearchProject, fk_idEmployee, ColabStartTime)
VALUES
(2,19,GETDATE());

INSERT INTO ResearchProjectXEmployee
(fk_idResearchProject, fk_idEmployee, ColabStartTime)
VALUES
(2,47,GETDATE());





INSERT INTO ResearchProject
(Budget, StartTime, "Description")
VALUES
(500000, GETDATE(), 'AI robot designed to protect endangered species.');

INSERT INTO ResearchProjectXEmployee
(fk_idResearchProject, fk_idEmployee, ColabStartTime)
VALUES
(3,51,GETDATE());

INSERT INTO ResearchProjectXEmployee
(fk_idResearchProject, fk_idEmployee, ColabStartTime)
VALUES
(3,19,GETDATE());

INSERT INTO ResearchProjectXEmployee
(fk_idResearchProject, fk_idEmployee, ColabStartTime)
VALUES
(3,55,GETDATE());