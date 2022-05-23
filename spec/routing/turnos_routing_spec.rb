# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TurnosController, type: :routing do
    describe 'routing' do
        it 'routes to #index' do
            expect(get: '/turnos').to route_to('turnos#index')
        end

        it 'routes to #new' do
            expect(get: '/turnos/new').to route_to('turnos#new')
        end

        it 'routes to #show' do
            expect(get: '/turnos/1').to route_to('turnos#show', id: '1')
        end

        it 'routes to #edit' do
            expect(get: '/turnos/1/edit').to route_to('turnos#edit', id: '1')
        end

        it 'routes to #create' do
            expect(post: '/turnos').to route_to('turnos#create')
        end

        it 'routes to #update via PUT' do
            expect(put: '/turnos/1').to route_to('turnos#update', id: '1')
        end

        it 'routes to #update via PATCH' do
            expect(patch: '/turnos/1').to route_to('turnos#update', id: '1')
        end

        it 'routes to #destroy' do
            expect(delete: '/turnos/1').to route_to('turnos#destroy', id: '1')
        end
    end
end
