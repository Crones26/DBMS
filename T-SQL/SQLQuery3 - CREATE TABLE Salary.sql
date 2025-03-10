USE PV_319_Import;
GO

CREATE TABLE Salary
(
	payment_id	BIGINT		PRIMARY KEY,
	teacher		SMALLINT	NOT NULL CONSTRAINT FK_Salary_Teachers REFERENCES Teachers(teacher_id),
	accrued		SMALLMONEY	NOT NULL,
	received	BIT			NOT NULL
);