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