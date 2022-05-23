# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/turnos', type: :request do
    # This should return the minimal set of attributes required to create a valid
    # Turno. As you add validations to Turno, be sure to
    # adjust the attributes here as well.
    before(:all) do
        @user = User.create!(email: 'test@mail.com',
                             password: 'testpassword123',
                             password_confirmation: 'testpassword123',
                             address: 'calle123',
                             phone: '56956569',
                             username: 'Test Name')
    end

    before(:each) do
        sign_in @user
    end

    after(:all) do
        sign_out @user
        @user.destroy
    end

    let(:valid_attributes) do
        { address_in: 'Campus San Joaquin', address_out: 'Tobalaba 1', capacity: '4', route: 'ida', day: 'lunes',
          hour: '16:00', user_id: @user.id }
    end

    let(:invalid_attributes) do
        { address_in: nil, address_out: nil, capacity: nil, route: nil, day: nil, hour: nil }
    end

    describe 'GET /index' do
        it 'renders a successful response' do
            @user.turnos.create! valid_attributes
            get turnos_url
            expect(response).to be_successful
        end
    end

    describe 'GET /show' do
        it 'renders a successful response' do
            @turno = @user.turnos.create! valid_attributes
            get "/turnos/#{@turno.id}"
            expect(response).to be_successful
        end
    end

    describe 'GET /new' do
        it 'renders a successful response' do
            get new_turno_url
            expect(response).to be_successful
        end
    end

    describe 'GET /edit' do
        it 'renders a successful response' do
            turno = Turno.create! valid_attributes
            get edit_turno_url(turno)
            expect(response).to be_successful
        end
    end

    describe 'POST /create' do
        context 'with valid parameters' do
            it 'creates a new Turno' do
                expect do
                    post turnos_url, params: { turno: valid_attributes }
                end.to change(Turno, :count).by(1)
            end

            it 'redirects to the created turno' do
                post turnos_url, params: { turno: valid_attributes }
                expect(response).to redirect_to(turno_url(Turno.last))
            end
        end

        context 'with invalid parameters' do
            it 'does not create a new Turno' do
                expect do
                    post turnos_url, params: { turno: invalid_attributes }
                end.to change(Turno, :count).by(0)
            end

            it "renders a successful response (i.e. to display the 'new' template)" do
                post turnos_url, params: { turno: invalid_attributes }
                expect(response).not_to be_successful
            end
        end
    end

    describe 'PATCH /update' do
        context 'with valid parameters' do
            let(:new_attributes) do
                { address_in: 'New valid destination address',
                  address_out: 'New valid departure address',
                  capacity: '7',
                  route: 'vuelta',
                  day: 'martes',
                  hour: '18:00' }
            end

            it 'updates the requested turno' do
                turno = Turno.create! valid_attributes
                patch turno_url(turno), params: { turno: new_attributes }
                turno.reload
                assert turno.save
            end

            it 'redirects to the turno' do
                turno = Turno.create! valid_attributes
                patch turno_url(turno), params: { turno: new_attributes }
                turno.reload
                expect(response).to redirect_to(turno_url(turno))
            end
        end

        context 'with invalid parameters' do
            it "renders a successful response (i.e. to display the 'edit' template)" do
                turno = Turno.create! valid_attributes
                patch turno_url(turno), params: { turno: invalid_attributes }
                expect(response).not_to be_successful
            end
        end
    end

    describe 'DELETE /destroy' do
        it 'destroys the requested turno' do
            turno = Turno.create! valid_attributes
            expect do
                delete turno_url(turno)
            end.to change(Turno, :count).by(-1)
        end

        it 'redirects to the turnos list' do
            turno = Turno.create! valid_attributes
            delete turno_url(turno)
            expect(response).to redirect_to(turnos_url)
        end
    end
end
