-- =============================================================
-- Stored Procedure: refresh_policy_policyholder
-- Truncates and reloads the policy_policyholder combined table.
-- Call with:  CALL refresh_policy_policyholder();
-- =============================================================

CREATE OR REPLACE PROCEDURE refresh_policy_policyholder()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Wipe the combined table
    TRUNCATE TABLE policy_policyholder;

    -- Reload from source tables
    INSERT INTO policy_policyholder (
        policy_id,
        policyholder_id,
        name,
        surname,
        dob,
        sex,
        product,
        sum_insured,
        annual_premium,
        premium_multiple
    )
    SELECT
        p.id                                        AS policy_id,
        ph.id                                       AS policyholder_id,
        ph.name,
        ph.surname,
        ph.dob,
        ph.sex,
        p.product,
        p.sum_insured,
        p.annual_premium,
        ROUND(p.sum_insured / p.annual_premium, 4)  AS premium_multiple
    FROM policies p
    JOIN policyholders ph ON ph.id = p.policyholder_id
    ORDER BY p.id;

    RAISE NOTICE 'policy_policyholder refreshed: % rows loaded.',
        (SELECT COUNT(*) FROM policy_policyholder);
END;
$$;
