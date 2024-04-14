module creator::split2{
    use std::vector;
    use std::signer;
    use std::event;

    struct Groups has key,store{
        groups : vector<Group>
    }

    struct Group has key,store,copy,drop {
        owner : address,
        is_deleted : bool,
        members : vector<address>,
        bills: vector<Bill>
    }

    struct Bill has key,store,copy,drop{
        created_by: address,
        title:vector<u8>,
        applied_to:vector<BillSplit>
    }

    struct BillSplit has key,store,copy,drop{
        member : address,
        amount: u64,
        paid: bool,
        amount_paid: u64
    }

    struct LocalState has key,store,copy{
        ids: vector<u64>,
        name: vector<u8>
    }

    #[event]
    struct LogEvent has key,store,drop{
        msg:vector<u8>,
    }

    public entry fun initialize(account: &signer) {
        if(signer::address_of(account)==@creator){
            if(!exists<Groups>(@creator)){
                let new_groups = Groups {
                    groups : vector::empty<Group>()
                };
                move_to<Groups>(account,new_groups);
                let eve = LogEvent {
                    msg:b"Groups Initialized Successfully"
                };
                event::emit(eve);
            }else{
                let eve = LogEvent {
                    msg:b"Groups Already Initialized"
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

    public entry fun create_group(sender:signer,members:vector<address>) acquires Groups,LocalState {
        let owner = signer::address_of(&sender);
        if(exists<Groups>(@creator)){
            let len = vector::length<address>(&members);
            let i = 0;
            while (i < len) {
                let add = *vector::borrow(&members, i);
                if(!exists<LocalState>(add)){
                    break
                };
                i = i + 1;
            };
            if(i==len){
            let existing_groups = borrow_global_mut<Groups>(@creator);
            let new_id = vector::length<Group>(&existing_groups.groups)+1;
            let new_group = Group {
                owner:owner,
                is_deleted:false,
                members: members,
                bills : vector::empty<Bill>()
            };
            vector::push_back<Group>(&mut existing_groups.groups,new_group);
            if(exists<LocalState>(owner)){
                let existing_assigned_groups = borrow_global_mut<LocalState>(owner);
                vector::push_back<u64>(&mut existing_assigned_groups.ids,new_id);
            }else{
                let new_assigned_groups = vector::singleton<u64>(new_id);
                move_to<LocalState>(&sender,LocalState { ids:new_assigned_groups,name:b"" });
            };

            let len = vector::length<address>(&members);
            let i = 0;
            while (i < len) {
                let add = *vector::borrow(&members, i);
                if(exists<LocalState>(add)){
                    let existing_assigned_groups = borrow_global_mut<LocalState>(add);
                    vector::push_back<u64>(&mut existing_assigned_groups.ids,new_id);
                }else{
                    break
                };
                i = i + 1;
            };
                let eve = LogEvent {
                    msg:b"Added Group Successfully"
                };
                event::emit(eve);    
            }else{
                let eve = LogEvent {
                    msg:b"Some Members are not registered in this app"
                };
                event::emit(eve);  
            }
            
        }else{
            let eve = LogEvent {
                            msg:b"No Groups are initialized"
                        };
            event::emit(eve);
        }
    }

    public entry fun add_split(account:signer,group_id:u64,title:vector<u8>,applied_to:vector<BillSplit>) acquires Groups,LocalState{
        if(exists<Groups>(@creator)){
            if(exists<LocalState>(signer::address_of(&account))){
                let ids = borrow_global_mut<LocalState>(signer::address_of(&account));
                if(vector::contains<u64>(&ids.ids,&group_id)){
                    let groups = borrow_global_mut<Groups>(@creator);
                    let group = *vector::borrow<Group>(&groups.groups,group_id);
                    vector::push_back<Bill>(&mut group.bills, Bill { created_by:signer::address_of(&account),title:title,applied_to:applied_to});
                    let eve = LogEvent {
                            msg:b"Bill Split added successfully"
                        };
                event::emit(eve);
                }else{
                    let eve = LogEvent {
                            msg:b"This Group is not accessable to you"
                        };
                event::emit(eve);
                }
            }else{
                let eve = LogEvent {
                            msg:b"No Account available"
                        };
                event::emit(eve);
            }
        }else{
            let eve = LogEvent {
                            msg:b"No Groups are initialized"
                        };
            event::emit(eve);
        }
    }

    #[view]
    public fun get_groups(sender:address) : vector<Group> acquires LocalState,Groups{
        let res = vector::empty<Group>();
        if(exists<Groups>(@creator)){
            if(exists<LocalState>(sender)){
                let assigned_ids = borrow_global<LocalState>(sender);
                let groups = borrow_global<Groups>(@creator);
                let len = vector::length<u64>(&assigned_ids.ids);
                let i = 0;
                let grps : vector<Group> = vector::empty<Group>();
                while (i < len) {
                    let id = *vector::borrow(&assigned_ids.ids, i);
                    let group = *vector::borrow<Group>(&groups.groups,id);
                    vector::push_back<Group>(&mut grps, group);
                    i = i + 1;
                };
                res = grps;
            };
        };
        res
    }

    #[view]
    public fun is_registered(sender:address):bool{
        if(exists<LocalState>(sender)) true else false
    }

    public entry fun register(sender:signer,name:vector<u8>){
        if(exists<LocalState>(signer::address_of(&sender))){
            let eve = LogEvent {
                            msg:b"Account Already Registered"
                        };
            event::emit(eve);
        }else{
            let local = LocalState {
                ids : vector::empty<u64>(),
                name: name
            };
            move_to<LocalState>(&sender,local);
            let eve = LogEvent {
                            msg:b"Account Registered Successfully"
                        };
            event::emit(eve);
        }
    }
}