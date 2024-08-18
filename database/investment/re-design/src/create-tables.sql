CREATE TABLE banks (
    bank_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    bank_name VARCHAR(255) NOT NULL,
    bank_code VARCHAR(10) UNIQUE NOT NULL,
    address TEXT,
    contact_info VARCHAR(255)
);

CREATE TABLE account_types (
    account_type_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_type_name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE accounts (
    account_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    bank_id INT REFERENCES banks(bank_id) ON DELETE CASCADE,
    account_type_id INT REFERENCES account_types(account_type_id) ON DELETE SET NULL,
    balance DECIMAL(15,2) NOT NULL DEFAULT 0.0,
    account_holder_name VARCHAR(255) NOT NULL,
    opened_date DATE NOT NULL DEFAULT CURRENT_DATE,
    interest_rate DECIMAL(5,2) NOT NULL DEFAULT 0.0,  -- Interest rate specific to this account
    tax_rate DECIMAL(5,2) NOT NULL DEFAULT 0.0  -- Tax rate specific to the account
);

CREATE TABLE transfers (
    transfer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    from_account_id INT REFERENCES accounts(account_id) ON DELETE CASCADE,
    to_account_id INT REFERENCES accounts(account_id) ON DELETE CASCADE,
    transfer_amount DECIMAL(15,2) NOT NULL,
    transfer_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description TEXT
);

CREATE TABLE reports (
    report_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id) ON DELETE CASCADE,
    report_date DATE NOT NULL,
    balance DECIMAL(15,2) NOT NULL,
    interest_earned DECIMAL(15,2),
    tax_paid DECIMAL(15,2),
    report_details TEXT
);

CREATE TABLE taxes (
    tax_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id) ON DELETE CASCADE,
    tax_year INT NOT NULL,
    total_taxable_income DECIMAL(15,2) NOT NULL,
    tax_rate DECIMAL(5,2) NOT NULL DEFAULT 0.0,
    tax_paid DECIMAL(15,2) NOT NULL,
    tax_due DECIMAL(15,2) GENERATED ALWAYS AS (total_taxable_income * tax_rate / 100 - tax_paid) STORED
);
