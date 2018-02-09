class DestroyJob < ApplicationJob
  queue_as :destroy

  def perform(object)
    object.destroy
  end
end
