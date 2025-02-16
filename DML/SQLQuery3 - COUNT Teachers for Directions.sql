USE PV_319_Import;
GO

SELECT
		[Направление обучения ]		=	direction_name,
		[Количество преподавателей]	=	
			(SELECT COUNT(DISTINCT teacher_id) 
			FROM Teachers, TeachersDisciplinesRelation, DisciplinesDirectionsRelation
			WHERE Teachers.teacher_id	=	TeachersDisciplinesRelation.teacher
			AND TeachersDisciplinesRelation.discipline	= DisciplinesDirectionsRelation.discipline
			AND DisciplinesDirectionsRelation.direction = direction_id
			)
			
FROM Directions;
-- GROUP BY direction_name;

SELECT discipline_name, COUNT(DISTINCT teacher_id) AS number_of_teachers
FROM Teachers, Disciplines, TeachersDisciplinesRelation
WHERE teacher	=	teacher_id
AND discipline	=	discipline_id
GROUP BY discipline_name;