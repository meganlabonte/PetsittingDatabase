# PetsittingDatabase

## Overview
This database is inspired by my own petsitting business. It's designed to support the operations of a pet-sitting business by tracking customers, their pets, and scheduled pet-sitting services.

## Key Features

- Normalization: The database is normalized to avoid redundancy and ensure data integrity.
- Constraints:
NOT NULL: Ensures essential fields must have values.
CHECK: Ensures conditions are met (e.g., weight must be greater than 0).
PRIMARY KEY and FOREIGN KEY: Enforce relationships and data integrity.
- Stored Procedure: A stored procedure (ReschedulePetSit) allows rescheduling of bookings by updating start and end dates for a given customer.

## Sample Data

The database includes sample data provided by chatgpt for each table:

- dogs, 8 cats, and 8 hamsters, with details like weight, age, and allergens.
- customers, each linked to a pet.
- pet-sitting bookings with start and end dates, week numbers, and prices.

