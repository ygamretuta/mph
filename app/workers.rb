class MbbWorker
	include Sidekiq::Worker

	def perform
		Transaction.cleanup
	end
end