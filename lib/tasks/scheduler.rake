desc 'Destroy all unsuccessful transactions more than 30 days old'
task :cleanup_transactions do
  Transaction.cleanup
end

desc 'Reset allowed ads for non-admin users each day. Value is not checked for admin users'
task :reset_allowed_ads do
  User.all.each do |u|
    unless user.has_role?(:admin)
      u.update(allowed_ads_today:2)
    end
  end
end

desc 'Delete all read notifications 1 week old'
task :delete_1_week_notifications do
  Notififaction.each do |n|
    if n.is_read? && n.created_at < 1.week.ago
      n.delete
    end
  end
end