CREATE INDEX tenant_created ON competition(`tenant_id`, `created_at`);
CREATE INDEX tenant_compe ON player_score(`tenant_id`, `player_id`);