-- =============================================================
-- Seed Data  –  policyholders & policies
-- Run after 01_tables.sql
-- =============================================================

-- ── Policyholders ─────────────────────────────────────────────
TRUNCATE TABLE policy_policyholder;
TRUNCATE TABLE policies CASCADE;
TRUNCATE TABLE policyholders CASCADE;

INSERT INTO policyholders (name, surname, dob, sex) VALUES
    ('James',       'Smith',     '1980-03-15', 'M'),
    ('Sarah',       'Johnson',   '1975-07-22', 'F'),
    ('Michael',     'Williams',  '1990-01-10', 'M'),
    ('Emma',        'Brown',     '1985-11-05', 'F'),
    ('David',       'Jones',     '1970-09-30', 'M'),
    ('Olivia',      'Davis',     '1995-04-18', 'F'),
    ('Christopher', 'Miller',    '1968-12-01', 'M'),
    ('Sophia',      'Wilson',    '1988-06-25', 'F'),
    ('Robert',      'Moore',     '1978-02-14', 'M'),
    ('Isabella',    'Taylor',    '1992-08-07', 'F'),
    ('William',     'Anderson',  '1983-05-20', 'M'),
    ('Mia',         'Thomas',    '1998-10-12', 'F'),
    ('Joseph',      'Jackson',   '1965-01-28', 'M'),
    ('Charlotte',   'White',     '1987-03-09', 'F'),
    ('Daniel',      'Harris',    '1973-07-16', 'M');

-- ── Policies ──────────────────────────────────────────────────
-- sum_insured: 200 000 – 5 000 000
-- annual_premium: 2 000 – 50 000  (correlated ~ 0.5%–1.2% of sum_insured)
-- premium_multiple (sum_insured / premium) appears in the combined table

INSERT INTO policies (policyholder_id, product, sum_insured, annual_premium) VALUES
    -- James Smith
    (1,  'product1',  500000.00,   3500.00),
    (1,  'product2', 1500000.00,  14250.00),
    -- Sarah Johnson
    (2,  'product1',  250000.00,   2100.00),
    -- Michael Williams
    (3,  'product2', 3000000.00,  28500.00),
    (3,  'product1',  750000.00,   5250.00),
    -- Emma Brown
    (4,  'product1',  200000.00,   2000.00),
    (4,  'product2',  800000.00,   7600.00),
    -- David Jones
    (5,  'product2', 5000000.00,  50000.00),
    -- Olivia Davis
    (6,  'product1',  350000.00,   2800.00),
    -- Christopher Miller
    (7,  'product2', 4000000.00,  40000.00),
    (7,  'product1', 1000000.00,   7000.00),
    -- Sophia Wilson
    (8,  'product1',  600000.00,   4200.00),
    (8,  'product2', 2500000.00,  23750.00),
    -- Robert Moore
    (9,  'product1',  450000.00,   3150.00),
    -- Isabella Taylor
    (10, 'product2', 1200000.00,  11400.00),
    (10, 'product1',  300000.00,   2400.00),
    -- William Anderson
    (11, 'product2', 2000000.00,  18000.00),
    -- Mia Thomas
    (12, 'product1',  400000.00,   3200.00),
    -- Joseph Jackson
    (13, 'product2', 4500000.00,  45000.00),
    (13, 'product1', 1800000.00,  13500.00),
    -- Charlotte White
    (14, 'product1',  550000.00,   3850.00),
    (14, 'product2', 2200000.00,  20900.00),
    -- Daniel Harris
    (15, 'product2', 3500000.00,  33250.00),
    (15, 'product1',  900000.00,   6300.00);
