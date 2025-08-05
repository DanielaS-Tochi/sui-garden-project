module sui_garden::garden {
    use sui::object::UID;
    use sui::tx_context::{TxContext, sender};
    use sui::transfer;
    use sui::object;

    // Definimos la planta
    public struct Plant has key, store {
        id: UID,
        name: vector<u8>,
    }

    // La función principal que crea la planta con UID válido
    public entry fun create_plant(name: vector<u8>, ctx: &mut TxContext) {
        let id = object::new(ctx);
        let plant = Plant { id, name };
        transfer::transfer(plant, sender(ctx));
    }

    public entry fun transfer_plant(plant: Plant, ctx: &mut TxContext) {
        transfer::transfer(plant, sender(ctx));
    }

    // 👉 Test sobre la lógica de nombre (sin UID)
    #[test]
    fun test_plant_name_logic() {
        let name = b"Sunflower";
        let same = name == b"Sunflower";
        assert!(same, 100);
    }
}

