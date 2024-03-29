describe 'Test drinks model', ->

    it 'should be a model', ->
        { default: Model } = await import('../../build/models/model.js')
        drink = new Model 'drinks', 'test'
        expect drink
            .to.be.a Model

    it 'should have the basic CRUD methods', ->
        { default: Model } = await import('../../build/models/model.js')
        drink = new Model 'drinks', 'test'
        expect drink
            .to.have.property 'create'
        expect drink
            .to.have.property 'read'
        expect drink
            .to.have.property 'readOne'
        expect drink
            .to.have.property 'update'
        expect drink
            .to.have.property 'delete'

    it 'should inherit the CRUD methods from Model', ->
        { default: Drink } = await import('../../build/models/drink.js')
        drink = new Drink
        expect drink
            .to.have.property 'create'
        expect drink
            .to.have.property 'read'
        expect drink
            .to.have.property 'readOne'
        expect drink
            .to.have.property 'update'
        expect drink
            .to.have.property 'delete'
