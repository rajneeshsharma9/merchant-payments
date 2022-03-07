# A background Job for deleting transactions older than an hour (cron job)
every :hour do
  rake 'transaction:destroy_stale'
end
