class GoodsController < ApplicationController
    def index
        @actors =  Actor.all
        render json: @actors
    end

    def actor_details
        @actor = Rails.cache.fetch("actor_#{params[:id]}", expires_in: 10.minutes) do
            puts "DB query running..."
            Actor.find(params[:id])
        end
        render json: @actor
    end

    def gc_stats
        GC.start
        before = GC.stat
    
        temp = []
        100_000.times { temp << "gc_test".dup }
        temp = nil
    
        GC.start
        after = GC.stat
    
        render json: {
          before_gc: {
            total_allocated_objects: before[:total_allocated_objects],
            gc_count: before[:count]
          },
          after_gc: {
            total_allocated_objects: after[:total_allocated_objects],
            gc_count: after[:count]
          }
        }
    end
end
