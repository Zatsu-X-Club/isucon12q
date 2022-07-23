CREATE INDEX tenant_created ON competition(`tenant_id`, `created_at`);
CREATE INDEX tenant_compe ON player_score(`tenant_id`, `player_id`);
create index tenant_compe_row on player_score(`tenant_id`,`competition_id`,`row_num`);