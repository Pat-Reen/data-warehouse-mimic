-- =============================================================
-- Table Definitions
-- =============================================================

CREATE TABLE IF NOT EXISTS policyholders (
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    surname    VARCHAR(100) NOT NULL,
    dob        DATE         NOT NULL,
    sex        CHAR(1)      NOT NULL CHECK (sex IN ('M', 'F'))
);

CREATE TABLE IF NOT EXISTS policies (
    id                SERIAL PRIMARY KEY,
    policyholder_id   INTEGER        NOT NULL REFERENCES policyholders(id),
    product           VARCHAR(20)    NOT NULL CHECK (product IN ('product1', 'product2')),
    sum_insured       NUMERIC(12, 2) NOT NULL CHECK (sum_insured  BETWEEN 200000   AND 5000000),
    annual_premium    NUMERIC(10, 2) NOT NULL CHECK (annual_premium BETWEEN 2000 AND 50000)
);

CREATE TABLE IF NOT EXISTS policy_policyholder (
    policy_id         INTEGER,
    policyholder_id   INTEGER,
    name              VARCHAR(100),
    surname           VARCHAR(100),
    dob               DATE,
    sex               CHAR(1),
    product           VARCHAR(20),
    sum_insured       NUMERIC(12, 2),
    annual_premium    NUMERIC(10, 2),
    premium_multiple  NUMERIC(12, 4)
);
