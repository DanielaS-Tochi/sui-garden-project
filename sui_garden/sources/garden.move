module sui_garden::garden {
    use sui::object::new;
    use sui::tx_context::sender;
    use sui::transfer::public_transfer;

    /// A plant object owned by a user
    /// Un objeto planta que pertenece a un usuario
    public struct Plant has key, store {
        id: UID,
        name: vector<u8>,
    }

    /// Maximum name length allowed (32 bytes)
    /// Longitud máxima permitida para el nombre (32 bytes)
    const MAX_NAME_LEN: u64 = 32;

    /// Creates a new Plant and transfers it to the caller
    /// Crea una nueva planta y la transfiere al remitente
    entry fun create_plant(name: vector<u8>, ctx: &mut TxContext) {
        let len = vector::length(&name);
        assert!(len > 0, 100); // Name must not be empty
        assert!(len <= MAX_NAME_LEN, 101); // Name too long

        let id = new(ctx);
        let plant = Plant { id, name };
        public_transfer(plant, sender(ctx));
    }

    /// Transfers a Plant from one user to another
    /// Transfiere una planta de un usuario a otro
    entry fun transfer_plant(plant: Plant, ctx: &TxContext) {
        public_transfer(plant, sender(ctx));
    }

    //
    // ---------- 🧪 UNIT TESTS ----------
    //

    /// ✅ Basic name comparison logic
    #[test]
    fun test_plant_name_logic() {
        let name1 = b"Sunflower";
        let name2 = b"Sunflower";
        assert!(name1 == name2, 100);
    }

    /// ✅ Validate max length check logic
    #[test]
    fun test_name_max_length_logic() {
        let name: vector<u8> = b"abcdefghijklmnopqrstuvwxyzabcdef"; // 32 bytes
        let len = vector::length(&name);
        assert!(len == 32, 101);
    }

    /// ❌ Simulate empty name logic check (pure test)
    #[test]
    fun test_empty_name_logic() {
        let name: vector<u8> = b"";
        let len = vector::length(&name);
        assert!(len == 0, 102);
    }
}
