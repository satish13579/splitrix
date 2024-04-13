module creator::splitrix{
    use std::debug;
    use std::vector;
    use std::signer;
    use std::account;
    use std::event;

    struct Groups has key,store{
        groups : vector<Group>
    }

    struct Group has key,store {
        owner : address,
        is_deleted : bool,
        members : vector<address>,
        bills: vector<Bill>
    }

    struct Bill has key,store{
        created_by: address,
        title:vector<u32>,
        applied_to:vector<BillSplit>
    }

    struct BillSplit has key,store{
        member : address,
        amount: u64,
        paid: bool,
        amount_paid: u64
    }

    struct AssignedGroups has key,store{
        ids: vector<u64>
    }

    #[event]
    struct LogEvent has key,store,drop{
        msg:vector<u8>,
    }

    struct AdminResourceAccountInfo has key{
        resource_signer_cap: account::SignerCapability,
        resource_address : address
    }

    fun init_module(account: &signer) {
        if(signer::address_of(account)==@creator){
            if(!exists<AdminResourceAccountInfo>(@creator)){
                let (_resource, resource_signer_cap) = account::create_resource_account(account, b"SOMESEED");
                let resource_signer = account::create_signer_with_capability(&resource_signer_cap);
                let resource_address = signer::address_of(&resource_signer);
                move_to<AdminResourceAccountInfo>(account, AdminResourceAccountInfo {
                    resource_signer_cap,
                    resource_address
                });
                let eve = LogEvent {
                    msg:b"Resource Allocated Successfully"
                };
                event::emit(eve);
            }else{
                let eve = LogEvent {
                    msg:b"Capability Already Exists"
                };
                event::emit(eve);
            }
        }else{
            let eve = LogEvent {
                    msg:b"Only Admin Address Allowed"
                };
            event::emit(eve);
        }
    }

    public entry fun create_group(sender:signer,members:vector<address>) acquires Groups,AssignedGroups,AdminResourceAccountInfo {
        let owner = signer::address_of(&sender);
        let creator_capability = borrow_global<AdminResourceAccountInfo>(@creator);
        let creator_signer = account::create_signer_with_capability(&creator_capability.resource_signer_cap);
        if(exists<Groups>(@creator)){
            let existing_groups = borrow_global_mut<Groups>(@creator);
            let new_id = vector::length<Group>(&existing_groups.groups)+1;
            let new_group = Group {
                owner:owner,
                is_deleted:false,
                members: members,
                bills : vector::empty<Bill>()
            };
            vector::push_back<Group>(&mut existing_groups.groups,new_group);
            if(exists<AssignedGroups>(owner)){
                let existing_assigned_groups = borrow_global_mut<AssignedGroups>(owner);
                vector::push_back<u64>(&mut existing_assigned_groups.ids,new_id);
            }else{
                let new_assigned_groups = vector::singleton<u64>(new_id);
                move_to<AssignedGroups>(&sender,AssignedGroups { ids:new_assigned_groups });
            };
        } else{
            let new_Groups = Groups {
                groups : vector::empty<Group>()
            };
            move_to<Groups>(&creator_signer,new_Groups);	
        };
    }

    #[view]
    public fun get_groups(sender:address) : bool acquires AssignedGroups{
        assert!(exists<AssignedGroups>(sender),404);
        let assigned_ids = borrow_global<AssignedGroups>(sender);
        let len = vector::length<u64>(&assigned_ids.ids);
            let i = 0;
    while (i < len) {
        let val = *vector::borrow(&assigned_ids.ids, i);
        debug::print(&val);
        i = i + 1;
    };
    true
    }
}