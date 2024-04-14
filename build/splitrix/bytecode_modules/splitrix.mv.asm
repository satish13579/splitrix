// Move bytecode v6
module a21eb1a7a80b2fa320ce11f9a8e7e42634558117b3e8f5ac50dac1a08780cb74.splitrix {
use 0000000000000000000000000000000000000000000000000000000000000001::account;
use 0000000000000000000000000000000000000000000000000000000000000001::debug;
use 0000000000000000000000000000000000000000000000000000000000000001::event;
use 0000000000000000000000000000000000000000000000000000000000000001::signer;
use 0000000000000000000000000000000000000000000000000000000000000001::vector;


struct AdminResourceAccountInfo has key {
	resource_signer_cap: SignerCapability,
	resource_address: address
}
struct AssignedGroups has store, key {
	ids: vector<u64>
}
struct Bill has store, key {
	created_by: address,
	title: vector<u32>,
	applied_to: vector<BillSplit>
}
struct BillSplit has store, key {
	member: address,
	amount: u64,
	paid: bool,
	amount_paid: u64
}
struct Group has store, key {
	owner: address,
	is_deleted: bool,
	members: vector<address>,
	bills: vector<Bill>
}
struct Groups has store, key {
	groups: vector<Group>
}
struct LogEvent has drop, store, key {
	msg: vector<u8>
}

entry public create_group(Arg0: signer, Arg1: vector<address>) /* def_idx: 0 */ {
L0:	loc2: Groups
L1:	loc3: vector<u64>
L2:	loc4: vector<u64>
L3:	loc5: Group
L4:	loc6: u64
L5:	loc7: address
B0:
	0: ImmBorrowLoc[0](Arg0: signer)
	1: Call signer::address_of(&signer): address
	2: StLoc[9](loc7: address)
	3: LdConst[0](Address: [162, 30, 177, 167, 168, 11, 47, 163, 32, 206, 17, 249, 168, 231, 228, 38, 52, 85, 129, 23, 179, 232, 245, 172, 80, 218, 193, 160, 135, 128, 203, 116])
	4: Exists[0](AdminResourceAccountInfo)
	5: BrFalse(96)
B1:
	6: LdConst[0](Address: [162, 30, 177, 167, 168, 11, 47, 163, 32, 206, 17, 249, 168, 231, 228, 38, 52, 85, 129, 23, 179, 232, 245, 172, 80, 218, 193, 160, 135, 128, 203, 116])
	7: ImmBorrowGlobal[0](AdminResourceAccountInfo)
	8: ImmBorrowField[0](AdminResourceAccountInfo.resource_signer_cap: SignerCapability)
	9: Call account::create_signer_with_capability(&SignerCapability): signer
	10: StLoc[2](loc0: signer)
	11: LdConst[0](Address: [162, 30, 177, 167, 168, 11, 47, 163, 32, 206, 17, 249, 168, 231, 228, 38, 52, 85, 129, 23, 179, 232, 245, 172, 80, 218, 193, 160, 135, 128, 203, 116])
	12: Exists[5](Groups)
	13: BrFalse(56)
B2:
	14: LdConst[0](Address: [162, 30, 177, 167, 168, 11, 47, 163, 32, 206, 17, 249, 168, 231, 228, 38, 52, 85, 129, 23, 179, 232, 245, 172, 80, 218, 193, 160, 135, 128, 203, 116])
	15: MutBorrowGlobal[5](Groups)
	16: StLoc[3](loc1: &mut Groups)
	17: CopyLoc[3](loc1: &mut Groups)
	18: ImmBorrowField[1](Groups.groups: vector<Group>)
	19: VecLen(8)
	20: LdU64(1)
	21: Add
	22: StLoc[8](loc6: u64)
	23: CopyLoc[9](loc7: address)
	24: LdFalse
	25: MoveLoc[1](Arg1: vector<address>)
	26: VecPack(9, 0)
	27: Pack[4](Group)
	28: StLoc[7](loc5: Group)
	29: MoveLoc[3](loc1: &mut Groups)
	30: MutBorrowField[1](Groups.groups: vector<Group>)
	31: MoveLoc[7](loc5: Group)
	32: VecPushBack(8)
	33: CopyLoc[9](loc7: address)
	34: Exists[1](AssignedGroups)
	35: BrFalse(45)
B3:
	36: MoveLoc[9](loc7: address)
	37: MutBorrowGlobal[1](AssignedGroups)
	38: MutBorrowField[2](AssignedGroups.ids: vector<u64>)
	39: MoveLoc[8](loc6: u64)
	40: VecPushBack(10)
	41: LdConst[1](Vector(U8): [24, 65, 100, 100, 101, 100, 32, 116, 111, 32, 101, 120, 105, 115, 116, 105, 110, 103, 32, 103, 114, 111, 117, 112, 115])
	42: Pack[6](LogEvent)
	43: Call event::emit<LogEvent>(LogEvent)
	44: Branch(55)
B4:
	45: MoveLoc[8](loc6: u64)
	46: Call vector::singleton<u64>(u64): vector<u64>
	47: StLoc[5](loc3: vector<u64>)
	48: ImmBorrowLoc[0](Arg0: signer)
	49: MoveLoc[5](loc3: vector<u64>)
	50: Pack[1](AssignedGroups)
	51: MoveTo[1](AssignedGroups)
	52: LdConst[2](Vector(U8): [17, 67, 114, 101, 97, 116, 101, 100, 32, 110, 101, 119, 32, 103, 114, 111, 117, 112])
	53: Pack[6](LogEvent)
	54: Call event::emit<LogEvent>(LogEvent)
B5:
	55: Branch(95)
B6:
	56: CopyLoc[9](loc7: address)
	57: LdFalse
	58: MoveLoc[1](Arg1: vector<address>)
	59: VecPack(9, 0)
	60: Pack[4](Group)
	61: Call vector::singleton<Group>(Group): vector<Group>
	62: Pack[5](Groups)
	63: StLoc[4](loc2: Groups)
	64: LdConst[3](Vector(U8): [11, 66, 101, 102, 111, 114, 101, 32, 77, 111, 118, 101])
	65: Pack[6](LogEvent)
	66: Call event::emit<LogEvent>(LogEvent)
	67: ImmBorrowLoc[2](loc0: signer)
	68: MoveLoc[4](loc2: Groups)
	69: MoveTo[5](Groups)
	70: LdConst[4](Vector(U8): [10, 65, 102, 116, 101, 114, 32, 77, 111, 118, 101])
	71: Pack[6](LogEvent)
	72: Call event::emit<LogEvent>(LogEvent)
	73: CopyLoc[9](loc7: address)
	74: Exists[1](AssignedGroups)
	75: BrFalse(85)
B7:
	76: MoveLoc[9](loc7: address)
	77: MutBorrowGlobal[1](AssignedGroups)
	78: MutBorrowField[2](AssignedGroups.ids: vector<u64>)
	79: LdU64(1)
	80: VecPushBack(10)
	81: LdConst[1](Vector(U8): [24, 65, 100, 100, 101, 100, 32, 116, 111, 32, 101, 120, 105, 115, 116, 105, 110, 103, 32, 103, 114, 111, 117, 112, 115])
	82: Pack[6](LogEvent)
	83: Call event::emit<LogEvent>(LogEvent)
	84: Branch(95)
B8:
	85: LdU64(1)
	86: Call vector::singleton<u64>(u64): vector<u64>
	87: StLoc[6](loc4: vector<u64>)
	88: ImmBorrowLoc[0](Arg0: signer)
	89: MoveLoc[6](loc4: vector<u64>)
	90: Pack[1](AssignedGroups)
	91: MoveTo[1](AssignedGroups)
	92: LdConst[2](Vector(U8): [17, 67, 114, 101, 97, 116, 101, 100, 32, 110, 101, 119, 32, 103, 114, 111, 117, 112])
	93: Pack[6](LogEvent)
	94: Call event::emit<LogEvent>(LogEvent)
B9:
	95: Branch(99)
B10:
	96: LdConst[5](Vector(U8): [23, 78, 111, 32, 65, 100, 109, 105, 110, 32, 82, 101, 115, 111, 117, 114, 99, 101, 32, 70, 111, 117, 110, 100])
	97: Pack[6](LogEvent)
	98: Call event::emit<LogEvent>(LogEvent)
B11:
	99: Ret
}
public get_groups(Arg0: address): bool /* def_idx: 1 */ {
L0:	loc1: u64
L1:	loc2: u64
L2:	loc3: u64
B0:
	0: CopyLoc[0](Arg0: address)
	1: Exists[1](AssignedGroups)
	2: BrFalse(4)
B1:
	3: Branch(6)
B2:
	4: LdU64(404)
	5: Abort
B3:
	6: MoveLoc[0](Arg0: address)
	7: ImmBorrowGlobal[1](AssignedGroups)
	8: StLoc[1](loc0: &AssignedGroups)
	9: CopyLoc[1](loc0: &AssignedGroups)
	10: ImmBorrowField[2](AssignedGroups.ids: vector<u64>)
	11: VecLen(10)
	12: StLoc[3](loc2: u64)
	13: LdU64(0)
	14: StLoc[2](loc1: u64)
B4:
	15: CopyLoc[2](loc1: u64)
	16: CopyLoc[3](loc2: u64)
	17: Lt
	18: BrFalse(33)
B5:
	19: Branch(20)
B6:
	20: CopyLoc[1](loc0: &AssignedGroups)
	21: ImmBorrowField[2](AssignedGroups.ids: vector<u64>)
	22: CopyLoc[2](loc1: u64)
	23: VecImmBorrow(10)
	24: ReadRef
	25: StLoc[4](loc3: u64)
	26: ImmBorrowLoc[4](loc3: u64)
	27: Call debug::print<u64>(&u64)
	28: MoveLoc[2](loc1: u64)
	29: LdU64(1)
	30: Add
	31: StLoc[2](loc1: u64)
	32: Branch(15)
B7:
	33: MoveLoc[1](loc0: &AssignedGroups)
	34: Pop
	35: LdTrue
	36: Ret
}
entry public initialize(Arg0: &signer) /* def_idx: 2 */ {
L0:	loc1: signer
L1:	loc2: SignerCapability
B0:
	0: CopyLoc[0](Arg0: &signer)
	1: Call signer::address_of(&signer): address
	2: LdConst[0](Address: [162, 30, 177, 167, 168, 11, 47, 163, 32, 206, 17, 249, 168, 231, 228, 38, 52, 85, 129, 23, 179, 232, 245, 172, 80, 218, 193, 160, 135, 128, 203, 116])
	3: Eq
	4: BrFalse(35)
B1:
	5: LdConst[0](Address: [162, 30, 177, 167, 168, 11, 47, 163, 32, 206, 17, 249, 168, 231, 228, 38, 52, 85, 129, 23, 179, 232, 245, 172, 80, 218, 193, 160, 135, 128, 203, 116])
	6: Exists[0](AdminResourceAccountInfo)
	7: Not
	8: BrFalse(29)
B2:
	9: CopyLoc[0](Arg0: &signer)
	10: LdConst[6](Vector(U8): [8, 83, 79, 77, 69, 83, 69, 69, 68])
	11: Call account::create_resource_account(&signer, vector<u8>): signer * SignerCapability
	12: StLoc[3](loc2: SignerCapability)
	13: Pop
	14: ImmBorrowLoc[3](loc2: SignerCapability)
	15: Call account::create_signer_with_capability(&SignerCapability): signer
	16: StLoc[2](loc1: signer)
	17: ImmBorrowLoc[2](loc1: signer)
	18: Call signer::address_of(&signer): address
	19: StLoc[1](loc0: address)
	20: MoveLoc[0](Arg0: &signer)
	21: MoveLoc[3](loc2: SignerCapability)
	22: MoveLoc[1](loc0: address)
	23: Pack[0](AdminResourceAccountInfo)
	24: MoveTo[0](AdminResourceAccountInfo)
	25: LdConst[7](Vector(U8): [31, 82, 101, 115, 111, 117, 114, 99, 101, 32, 65, 108, 108, 111, 99, 97, 116, 101, 100, 32, 83, 117, 99, 99, 101, 115, 115, 102, 117, 108, 108, 121])
	26: Pack[6](LogEvent)
	27: Call event::emit<LogEvent>(LogEvent)
	28: Branch(34)
B3:
	29: MoveLoc[0](Arg0: &signer)
	30: Pop
	31: LdConst[8](Vector(U8): [25, 67, 97, 112, 97, 98, 105, 108, 105, 116, 121, 32, 65, 108, 114, 101, 97, 100, 121, 32, 69, 120, 105, 115, 116, 115])
	32: Pack[6](LogEvent)
	33: Call event::emit<LogEvent>(LogEvent)
B4:
	34: Branch(40)
B5:
	35: MoveLoc[0](Arg0: &signer)
	36: Pop
	37: LdConst[9](Vector(U8): [26, 79, 110, 108, 121, 32, 65, 100, 109, 105, 110, 32, 65, 100, 100, 114, 101, 115, 115, 32, 65, 108, 108, 111, 119, 101, 100])
	38: Pack[6](LogEvent)
	39: Call event::emit<LogEvent>(LogEvent)
B6:
	40: Ret
}
}