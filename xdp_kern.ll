; ModuleID = 'xdp_kern.c'
source_filename = "xdp_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.StatData = type { i64, i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@hash_table_map = dso_local global %struct.bpf_map_def { i32 1, i32 4, i32 4, i32 10240, i32 0 }, section "maps", align 4, !dbg !0
@white_table_map = dso_local global %struct.bpf_map_def { i32 1, i32 4, i32 2, i32 2048, i32 0 }, section "maps", align 4, !dbg !104
@stat_map = dso_local global %struct.bpf_map_def { i32 1, i32 4, i32 24, i32 1, i32 0 }, section "maps", align 4, !dbg !114
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !116
@llvm.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.bpf_map_def* @hash_table_map to i8*), i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* bitcast (%struct.bpf_map_def* @white_table_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_main to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @get_seed() local_unnamed_addr #0 !dbg !145 {
  %1 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !151
  %2 = trunc i64 %1 to i32, !dbg !152
  call void @llvm.dbg.value(metadata i32 %2, metadata !150, metadata !DIExpression()), !dbg !153
  %3 = xor i32 %2, 1640531527, !dbg !154
  ret i32 %3, !dbg !155
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: norecurse nounwind readnone
define dso_local i64 @hash_sum(i64 %0, i16 zeroext %1) local_unnamed_addr #3 !dbg !156 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !161, metadata !DIExpression()), !dbg !164
  call void @llvm.dbg.value(metadata i16 %1, metadata !162, metadata !DIExpression()), !dbg !164
  %3 = mul i64 %0, 1640531527, !dbg !165
  call void @llvm.dbg.value(metadata i64 %3, metadata !163, metadata !DIExpression()), !dbg !164
  %4 = zext i16 %1 to i64, !dbg !166
  %5 = lshr i64 %3, %4, !dbg !166
  ret i64 %5, !dbg !167
}

; Function Attrs: nounwind
define dso_local i32 @hash_tcp_ip(i32 %0, i32 %1, i16 zeroext %2, i16 zeroext %3, i32 %4) local_unnamed_addr #0 !dbg !168 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !172, metadata !DIExpression()), !dbg !179
  call void @llvm.dbg.value(metadata i32 %1, metadata !173, metadata !DIExpression()), !dbg !179
  call void @llvm.dbg.value(metadata i16 %2, metadata !174, metadata !DIExpression()), !dbg !179
  call void @llvm.dbg.value(metadata i16 %3, metadata !175, metadata !DIExpression()), !dbg !179
  call void @llvm.dbg.value(metadata i32 %4, metadata !176, metadata !DIExpression()), !dbg !179
  %6 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !180
  call void @llvm.dbg.value(metadata i64 %6, metadata !150, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #4, !dbg !182
  call void @llvm.dbg.value(metadata i64 %6, metadata !177, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_constu, 1640531527, DW_OP_xor, DW_OP_stack_value)), !dbg !179
  %7 = zext i32 %1 to i64, !dbg !183
  %8 = shl nuw i64 %7, 32, !dbg !184
  %9 = zext i32 %0 to i64, !dbg !185
  %10 = or i64 %8, %9, !dbg !186
  call void @llvm.dbg.value(metadata i64 %10, metadata !161, metadata !DIExpression()), !dbg !187
  call void @llvm.dbg.value(metadata i64 %6, metadata !162, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_constu, 18446744073709520455, DW_OP_xor, DW_OP_stack_value)), !dbg !187
  %11 = mul i64 %10, 1640531527, !dbg !189
  call void @llvm.dbg.value(metadata i64 %11, metadata !163, metadata !DIExpression()), !dbg !187
  %12 = and i64 %6, 65535, !dbg !190
  %13 = xor i64 %12, 34375, !dbg !190
  %14 = lshr i64 %11, %13, !dbg !190
  call void @llvm.dbg.value(metadata i64 %14, metadata !178, metadata !DIExpression()), !dbg !179
  %15 = zext i16 %3 to i64, !dbg !191
  %16 = shl nuw i64 %15, 48, !dbg !192
  %17 = zext i32 %4 to i64, !dbg !193
  %18 = shl nuw nsw i64 %17, 16, !dbg !194
  %19 = zext i16 %2 to i64, !dbg !195
  %20 = or i64 %16, %19, !dbg !196
  %21 = or i64 %20, %18, !dbg !197
  call void @llvm.dbg.value(metadata i64 %21, metadata !161, metadata !DIExpression()), !dbg !198
  call void @llvm.dbg.value(metadata i64 %14, metadata !162, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !198
  %22 = mul i64 %21, 1640531527, !dbg !200
  call void @llvm.dbg.value(metadata i64 %22, metadata !163, metadata !DIExpression()), !dbg !198
  %23 = and i64 %14, 65535, !dbg !201
  %24 = lshr i64 %22, %23, !dbg !201
  %25 = trunc i64 %24 to i32, !dbg !202
  ret i32 %25, !dbg !203
}

; Function Attrs: nounwind
define dso_local i32 @hash_cookie(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !204 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !208, metadata !DIExpression()), !dbg !211
  call void @llvm.dbg.value(metadata i32 %1, metadata !209, metadata !DIExpression()), !dbg !211
  %3 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !212
  call void @llvm.dbg.value(metadata i64 %3, metadata !150, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #4, !dbg !214
  call void @llvm.dbg.value(metadata i64 %3, metadata !210, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_constu, 1640531527, DW_OP_xor, DW_OP_stack_value)), !dbg !211
  %4 = zext i32 %0 to i64, !dbg !215
  call void @llvm.dbg.value(metadata i64 %4, metadata !161, metadata !DIExpression()), !dbg !216
  call void @llvm.dbg.value(metadata i64 %3, metadata !162, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_constu, 18446744073709520455, DW_OP_xor, DW_OP_stack_value)), !dbg !216
  %5 = mul nuw nsw i64 %4, 1640531527, !dbg !218
  call void @llvm.dbg.value(metadata i64 %5, metadata !163, metadata !DIExpression()), !dbg !216
  %6 = and i64 %3, 65535, !dbg !219
  %7 = xor i64 %6, 34375, !dbg !219
  %8 = lshr i64 %5, %7, !dbg !219
  %9 = trunc i64 %8 to i32, !dbg !220
  %10 = add i32 %9, %1, !dbg !220
  ret i32 %10, !dbg !221
}

; Function Attrs: nounwind
define dso_local void @write_hash_table(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !222 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  call void @llvm.dbg.value(metadata i32 %0, metadata !226, metadata !DIExpression()), !dbg !228
  store i32 %0, i32* %3, align 4, !tbaa !229
  call void @llvm.dbg.value(metadata i32 %1, metadata !227, metadata !DIExpression()), !dbg !228
  store i32 %1, i32* %4, align 4, !tbaa !229
  %5 = bitcast i32* %4 to i8*, !dbg !233
  %6 = bitcast i32* %3 to i8*, !dbg !234
  call void @llvm.dbg.value(metadata i32* %3, metadata !226, metadata !DIExpression(DW_OP_deref)), !dbg !228
  call void @llvm.dbg.value(metadata i32* %4, metadata !227, metadata !DIExpression(DW_OP_deref)), !dbg !228
  %7 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @hash_table_map to i8*), i8* nonnull %5, i8* nonnull %6, i64 0) #4, !dbg !235
  ret void, !dbg !236
}

; Function Attrs: nounwind
define dso_local void @write_white_table(i16 signext %0, i32 %1) local_unnamed_addr #0 !dbg !237 {
  %3 = alloca i16, align 2
  %4 = alloca i32, align 4
  call void @llvm.dbg.value(metadata i16 %0, metadata !243, metadata !DIExpression()), !dbg !245
  store i16 %0, i16* %3, align 2, !tbaa !246
  call void @llvm.dbg.value(metadata i32 %1, metadata !244, metadata !DIExpression()), !dbg !245
  store i32 %1, i32* %4, align 4, !tbaa !229
  %5 = bitcast i32* %4 to i8*, !dbg !248
  %6 = bitcast i16* %3 to i8*, !dbg !249
  call void @llvm.dbg.value(metadata i16* %3, metadata !243, metadata !DIExpression(DW_OP_deref)), !dbg !245
  call void @llvm.dbg.value(metadata i32* %4, metadata !244, metadata !DIExpression(DW_OP_deref)), !dbg !245
  %7 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @white_table_map to i8*), i8* nonnull %5, i8* nonnull %6, i64 0) #4, !dbg !250
  ret void, !dbg !251
}

; Function Attrs: nounwind
define dso_local void @stat_white(i32 %0, i32 %1, i32 %2) local_unnamed_addr #0 !dbg !252 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.StatData, align 8
  call void @llvm.dbg.value(metadata i32 %0, metadata !257, metadata !DIExpression()), !dbg !273
  call void @llvm.dbg.value(metadata i32 %1, metadata !258, metadata !DIExpression()), !dbg !273
  call void @llvm.dbg.value(metadata i32 %2, metadata !259, metadata !DIExpression()), !dbg !273
  %6 = bitcast i32* %4 to i8*, !dbg !274
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %6) #4, !dbg !274
  call void @llvm.dbg.value(metadata i32 0, metadata !260, metadata !DIExpression()), !dbg !273
  store i32 0, i32* %4, align 4, !dbg !275, !tbaa !229
  call void @llvm.dbg.value(metadata i64 0, metadata !261, metadata !DIExpression()), !dbg !273
  call void @llvm.dbg.value(metadata i64 0, metadata !262, metadata !DIExpression()), !dbg !273
  call void @llvm.dbg.value(metadata i64 0, metadata !263, metadata !DIExpression()), !dbg !273
  call void @llvm.dbg.value(metadata i32* %4, metadata !260, metadata !DIExpression(DW_OP_deref)), !dbg !273
  %7 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %6) #4, !dbg !276
  call void @llvm.dbg.value(metadata i8* %7, metadata !264, metadata !DIExpression()), !dbg !273
  %8 = icmp eq i8* %7, null, !dbg !277
  br i1 %8, label %18, label %9, !dbg !279

9:                                                ; preds = %3
  call void @llvm.dbg.value(metadata i8* %7, metadata !264, metadata !DIExpression()), !dbg !273
  %10 = bitcast i8* %7 to i64*, !dbg !280
  %11 = load i64, i64* %10, align 8, !dbg !280, !tbaa !282
  call void @llvm.dbg.value(metadata i64 %11, metadata !261, metadata !DIExpression()), !dbg !273
  %12 = getelementptr inbounds i8, i8* %7, i64 8, !dbg !285
  %13 = bitcast i8* %12 to i64*, !dbg !285
  %14 = load i64, i64* %13, align 8, !dbg !285, !tbaa !286
  call void @llvm.dbg.value(metadata i64 %14, metadata !262, metadata !DIExpression()), !dbg !273
  %15 = getelementptr inbounds i8, i8* %7, i64 16, !dbg !287
  %16 = bitcast i8* %15 to i64*, !dbg !287
  %17 = load i64, i64* %16, align 8, !dbg !287, !tbaa !288
  call void @llvm.dbg.value(metadata i64 %17, metadata !263, metadata !DIExpression()), !dbg !273
  br label %18, !dbg !289

18:                                               ; preds = %3, %9
  %19 = phi i64 [ %14, %9 ], [ 0, %3 ], !dbg !273
  %20 = phi i64 [ %17, %9 ], [ 0, %3 ], !dbg !273
  %21 = phi i64 [ %11, %9 ], [ 0, %3 ], !dbg !273
  call void @llvm.dbg.value(metadata i64 %21, metadata !261, metadata !DIExpression()), !dbg !273
  call void @llvm.dbg.value(metadata i64 %20, metadata !263, metadata !DIExpression()), !dbg !273
  call void @llvm.dbg.value(metadata i64 %19, metadata !262, metadata !DIExpression()), !dbg !273
  %22 = bitcast %struct.StatData* %5 to i8*, !dbg !290
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %22) #4, !dbg !290
  call void @llvm.dbg.declare(metadata %struct.StatData* %5, metadata !272, metadata !DIExpression()), !dbg !291
  %23 = icmp eq i32 %0, 0, !dbg !292
  br i1 %23, label %28, label %24, !dbg !294

24:                                               ; preds = %18
  %25 = add i64 %21, 1, !dbg !295
  %26 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 0, !dbg !297
  store i64 %25, i64* %26, align 8, !dbg !298, !tbaa !282
  %27 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 1, !dbg !299
  store i64 %19, i64* %27, align 8, !dbg !300, !tbaa !286
  br label %40, !dbg !301

28:                                               ; preds = %18
  %29 = icmp eq i32 %1, 0, !dbg !302
  br i1 %29, label %34, label %30, !dbg !304

30:                                               ; preds = %28
  %31 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 0, !dbg !305
  store i64 %21, i64* %31, align 8, !dbg !307, !tbaa !282
  %32 = add i64 %19, 1, !dbg !308
  %33 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 1, !dbg !309
  store i64 %32, i64* %33, align 8, !dbg !310, !tbaa !286
  br label %40, !dbg !311

34:                                               ; preds = %28
  %35 = icmp ne i32 %2, 0, !dbg !312
  %36 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 0, !dbg !314
  store i64 %21, i64* %36, align 8, !dbg !314, !tbaa !282
  %37 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 1, !dbg !314
  store i64 %19, i64* %37, align 8, !dbg !314, !tbaa !286
  %38 = zext i1 %35 to i64, !dbg !315
  %39 = add i64 %20, %38, !dbg !315
  br label %40, !dbg !315

40:                                               ; preds = %34, %30, %24
  %41 = phi i64 [ %20, %30 ], [ %20, %24 ], [ %39, %34 ]
  %42 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 2, !dbg !316
  store i64 %41, i64* %42, align 8, !dbg !316, !tbaa !288
  call void @llvm.dbg.value(metadata i32* %4, metadata !260, metadata !DIExpression(DW_OP_deref)), !dbg !273
  %43 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %6, i8* nonnull %22, i64 0) #4, !dbg !317
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %22) #4, !dbg !318
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %6) #4, !dbg !318
  ret void, !dbg !318
}

; Function Attrs: nounwind
define dso_local i32 @xdp_main(%struct.xdp_md* nocapture readonly %0) #0 section "prog" !dbg !319 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.StatData, align 8
  call void @llvm.dbg.declare(metadata %struct.StatData* %3, metadata !272, metadata !DIExpression()), !dbg !371
  %4 = alloca i32, align 4
  %5 = alloca %struct.StatData, align 8
  call void @llvm.dbg.declare(metadata %struct.StatData* %5, metadata !272, metadata !DIExpression()), !dbg !374
  %6 = alloca i32, align 4
  %7 = alloca %struct.StatData, align 8
  call void @llvm.dbg.declare(metadata %struct.StatData* %7, metadata !272, metadata !DIExpression()), !dbg !376
  %8 = alloca i32, align 4
  %9 = alloca %struct.StatData, align 8
  call void @llvm.dbg.declare(metadata %struct.StatData* %9, metadata !272, metadata !DIExpression()), !dbg !378
  %10 = alloca i16, align 2
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %struct.StatData, align 8
  call void @llvm.dbg.declare(metadata %struct.StatData* %13, metadata !272, metadata !DIExpression()), !dbg !380
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca %struct.StatData, align 8
  call void @llvm.dbg.declare(metadata %struct.StatData* %17, metadata !272, metadata !DIExpression()), !dbg !382
  %18 = alloca i32, align 4
  %19 = alloca %struct.StatData, align 8
  call void @llvm.dbg.declare(metadata %struct.StatData* %19, metadata !272, metadata !DIExpression()), !dbg !385
  %20 = alloca i16, align 2
  %21 = alloca i32, align 4
  %22 = alloca %struct.ethhdr, align 1
  %23 = alloca %struct.ethhdr, align 1
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !331, metadata !DIExpression()), !dbg !387
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !332, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !387
  %24 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !388
  %25 = load i32, i32* %24, align 4, !dbg !388, !tbaa !389
  %26 = zext i32 %25 to i64, !dbg !391
  %27 = inttoptr i64 %26 to i8*, !dbg !391
  %28 = inttoptr i64 %26 to %struct.ethhdr*, !dbg !392
  call void @llvm.dbg.value(metadata %struct.ethhdr* %28, metadata !332, metadata !DIExpression(DW_OP_LLVM_fragment, 192, 64)), !dbg !387
  %29 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 1, i32 0, i64 0, !dbg !393
  %30 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !395
  %31 = load i32, i32* %30, align 4, !dbg !395, !tbaa !396
  %32 = zext i32 %31 to i64, !dbg !397
  %33 = inttoptr i64 %32 to i8*, !dbg !397
  %34 = icmp ugt i8* %29, %33, !dbg !398
  br i1 %34, label %346, label %35, !dbg !399

35:                                               ; preds = %1
  %36 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 0, i32 2, !dbg !400
  %37 = load i16, i16* %36, align 1, !dbg !400, !tbaa !402
  %38 = icmp eq i16 %37, 8, !dbg !404
  br i1 %38, label %39, label %346, !dbg !405

39:                                               ; preds = %35
  call void @llvm.dbg.value(metadata %struct.ethhdr* %28, metadata !339, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !387
  %40 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 2, i32 1, !dbg !406
  %41 = getelementptr [6 x i8], [6 x i8]* %40, i64 0, i64 0, !dbg !408
  %42 = icmp ugt i8* %41, %33, !dbg !409
  br i1 %42, label %346, label %43, !dbg !410

43:                                               ; preds = %39
  call void @llvm.dbg.value(metadata %struct.ethhdr* %28, metadata !332, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value, DW_OP_LLVM_fragment, 64, 64)), !dbg !387
  %44 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 1, i32 1, i64 3, !dbg !411
  %45 = load i8, i8* %44, align 1, !dbg !411, !tbaa !413
  %46 = icmp eq i8 %45, 6, !dbg !415
  br i1 %46, label %47, label %346, !dbg !416

47:                                               ; preds = %43
  call void @llvm.dbg.value(metadata [6 x i8]* %40, metadata !340, metadata !DIExpression()), !dbg !387
  %48 = getelementptr inbounds [6 x i8], [6 x i8]* %40, i64 3, i64 2, !dbg !417
  %49 = icmp ugt i8* %48, %33, !dbg !419
  br i1 %49, label %346, label %50, !dbg !420

50:                                               ; preds = %47
  call void @llvm.dbg.value(metadata [6 x i8]* %40, metadata !332, metadata !DIExpression(DW_OP_LLVM_fragment, 128, 64)), !dbg !387
  %51 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 2, i32 1, i64 2, !dbg !421
  %52 = bitcast i8* %51 to i16*, !dbg !421
  %53 = load i16, i16* %52, align 2, !dbg !421, !tbaa !422
  %54 = tail call i16 @llvm.bswap.i16(i16 %53)
  switch i16 %54, label %346 [
    i16 80, label %55
    i16 443, label %55
  ], !dbg !424

55:                                               ; preds = %50, %50
  %56 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 1, i32 2, !dbg !425
  %57 = bitcast i16* %56 to i32*, !dbg !425
  %58 = bitcast i16* %56 to i8*, !dbg !426
  %59 = tail call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @white_table_map to i8*), i8* nonnull %58) #4, !dbg !427
  call void @llvm.dbg.value(metadata i8* %59, metadata !341, metadata !DIExpression()), !dbg !428
  %60 = icmp eq i8* %59, null, !dbg !429
  br i1 %60, label %143, label %61, !dbg !430

61:                                               ; preds = %55
  %62 = bitcast i8* %59 to i16*, !dbg !427
  call void @llvm.dbg.value(metadata i16* %62, metadata !341, metadata !DIExpression()), !dbg !428
  %63 = load i16, i16* %62, align 2, !dbg !431, !tbaa !246
  %64 = icmp sgt i16 %63, 0, !dbg !432
  br i1 %64, label %65, label %143, !dbg !433

65:                                               ; preds = %61
  %66 = getelementptr inbounds [6 x i8], [6 x i8]* %40, i64 2, !dbg !434
  %67 = bitcast [6 x i8]* %66 to i16*, !dbg !434
  %68 = load i16, i16* %67, align 4, !dbg !434
  %69 = and i16 %68, 512, !dbg !434
  %70 = icmp eq i16 %69, 0, !dbg !435
  br i1 %70, label %120, label %71, !dbg !436

71:                                               ; preds = %65
  %72 = add nsw i16 %63, -1, !dbg !437
  call void @llvm.dbg.value(metadata i16 %72, metadata !345, metadata !DIExpression()), !dbg !438
  %73 = load i32, i32* %57, align 4, !dbg !439, !tbaa !440
  %74 = bitcast i16* %20 to i8*, !dbg !441
  call void @llvm.lifetime.start.p0i8(i64 2, i8* nonnull %74), !dbg !441
  %75 = bitcast i32* %21 to i8*, !dbg !441
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %75), !dbg !441
  call void @llvm.dbg.value(metadata i16 %72, metadata !243, metadata !DIExpression()) #4, !dbg !441
  store i16 %72, i16* %20, align 2, !tbaa !246
  call void @llvm.dbg.value(metadata i32 %73, metadata !244, metadata !DIExpression()) #4, !dbg !441
  store i32 %73, i32* %21, align 4, !tbaa !229
  call void @llvm.dbg.value(metadata i16* %20, metadata !243, metadata !DIExpression(DW_OP_deref)) #4, !dbg !441
  call void @llvm.dbg.value(metadata i32* %21, metadata !244, metadata !DIExpression(DW_OP_deref)) #4, !dbg !441
  %76 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @white_table_map to i8*), i8* nonnull %75, i8* nonnull %74, i64 0) #4, !dbg !443
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %74), !dbg !444
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %75), !dbg !444
  %77 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 2, i32 1, i64 4, !dbg !445
  %78 = bitcast i8* %77 to i32*, !dbg !445
  %79 = load i32, i32* %78, align 4, !dbg !445, !tbaa !446
  %80 = call i32 @llvm.bswap.i32(i32 %79), !dbg !445
  %81 = add i32 %80, 1, !dbg !445
  %82 = call i32 @llvm.bswap.i32(i32 %81), !dbg !445
  %83 = getelementptr inbounds [6 x i8], [6 x i8]* %40, i64 1, i64 2, !dbg !447
  %84 = bitcast i8* %83 to i32*, !dbg !447
  store i32 %82, i32* %84, align 4, !dbg !448, !tbaa !449
  store i32 0, i32* %78, align 4, !dbg !450, !tbaa !446
  %85 = load i16, i16* %67, align 4, !dbg !451
  %86 = or i16 %85, 4096, !dbg !451
  store i16 %86, i16* %67, align 4, !dbg !451
  %87 = bitcast [6 x i8]* %40 to i16*, !dbg !452
  %88 = load i16, i16* %87, align 4, !dbg !452, !tbaa !453
  call void @llvm.dbg.value(metadata i16 %88, metadata !350, metadata !DIExpression()), !dbg !438
  %89 = load i16, i16* %52, align 2, !dbg !454, !tbaa !422
  store i16 %89, i16* %87, align 4, !dbg !455, !tbaa !453
  store i16 %88, i16* %52, align 2, !dbg !456, !tbaa !422
  %90 = load i32, i32* %57, align 4, !dbg !457, !tbaa !440
  call void @llvm.dbg.value(metadata i32 %90, metadata !351, metadata !DIExpression()), !dbg !438
  %91 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 2, i32 0, i64 2, !dbg !458
  %92 = bitcast i8* %91 to i32*, !dbg !458
  %93 = load i32, i32* %92, align 4, !dbg !458, !tbaa !459
  store i32 %93, i32* %57, align 4, !dbg !460, !tbaa !440
  store i32 %90, i32* %92, align 4, !dbg !461, !tbaa !459
  %94 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %22, i64 0, i32 0, i64 0, !dbg !462
  call void @llvm.lifetime.start.p0i8(i64 14, i8* nonnull %94), !dbg !462
  call void @llvm.dbg.declare(metadata %struct.ethhdr* %22, metadata !352, metadata !DIExpression()), !dbg !463
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(14) %94, i8* nonnull align 1 dereferenceable(14) %27, i64 14, i1 false), !dbg !464, !tbaa.struct !465
  %95 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 0, i32 0, i64 0, !dbg !467
  %96 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %22, i64 0, i32 1, i64 0, !dbg !467
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %95, i8* nonnull align 1 dereferenceable(6) %96, i64 6, i1 false), !dbg !467
  %97 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 0, i32 1, i64 0, !dbg !468
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %97, i8* nonnull align 1 dereferenceable(6) %94, i64 6, i1 false), !dbg !468
  call void @llvm.dbg.value(metadata i32 0, metadata !257, metadata !DIExpression()) #4, !dbg !469
  call void @llvm.dbg.value(metadata i32 0, metadata !258, metadata !DIExpression()) #4, !dbg !469
  call void @llvm.dbg.value(metadata i32 1, metadata !259, metadata !DIExpression()) #4, !dbg !469
  %98 = bitcast i32* %18 to i8*, !dbg !470
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %98) #4, !dbg !470
  call void @llvm.dbg.value(metadata i32 0, metadata !260, metadata !DIExpression()) #4, !dbg !469
  store i32 0, i32* %18, align 4, !dbg !471, !tbaa !229
  call void @llvm.dbg.value(metadata i64 0, metadata !261, metadata !DIExpression()) #4, !dbg !469
  call void @llvm.dbg.value(metadata i64 0, metadata !262, metadata !DIExpression()) #4, !dbg !469
  call void @llvm.dbg.value(metadata i64 0, metadata !263, metadata !DIExpression()) #4, !dbg !469
  call void @llvm.dbg.value(metadata i32* %18, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !469
  %99 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %98) #4, !dbg !472
  call void @llvm.dbg.value(metadata i8* %99, metadata !264, metadata !DIExpression()) #4, !dbg !469
  %100 = icmp eq i8* %99, null, !dbg !473
  br i1 %100, label %111, label %101, !dbg !474

101:                                              ; preds = %71
  call void @llvm.dbg.value(metadata i8* %99, metadata !264, metadata !DIExpression()) #4, !dbg !469
  %102 = bitcast i8* %99 to i64*, !dbg !475
  %103 = load i64, i64* %102, align 8, !dbg !475, !tbaa !282
  call void @llvm.dbg.value(metadata i64 %103, metadata !261, metadata !DIExpression()) #4, !dbg !469
  %104 = getelementptr inbounds i8, i8* %99, i64 8, !dbg !476
  %105 = bitcast i8* %104 to i64*, !dbg !476
  %106 = load i64, i64* %105, align 8, !dbg !476, !tbaa !286
  call void @llvm.dbg.value(metadata i64 %106, metadata !262, metadata !DIExpression()) #4, !dbg !469
  %107 = getelementptr inbounds i8, i8* %99, i64 16, !dbg !477
  %108 = bitcast i8* %107 to i64*, !dbg !477
  %109 = load i64, i64* %108, align 8, !dbg !477, !tbaa !288
  call void @llvm.dbg.value(metadata i64 %109, metadata !263, metadata !DIExpression()) #4, !dbg !469
  %110 = add i64 %109, 1, !dbg !478
  br label %111, !dbg !478

111:                                              ; preds = %71, %101
  %112 = phi i64 [ %106, %101 ], [ 0, %71 ], !dbg !469
  %113 = phi i64 [ %110, %101 ], [ 1, %71 ]
  %114 = phi i64 [ %103, %101 ], [ 0, %71 ], !dbg !469
  call void @llvm.dbg.value(metadata i64 %114, metadata !261, metadata !DIExpression()) #4, !dbg !469
  call void @llvm.dbg.value(metadata i64 undef, metadata !263, metadata !DIExpression()) #4, !dbg !469
  call void @llvm.dbg.value(metadata i64 %112, metadata !262, metadata !DIExpression()) #4, !dbg !469
  %115 = bitcast %struct.StatData* %19 to i8*, !dbg !479
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %115) #4, !dbg !479
  %116 = getelementptr inbounds %struct.StatData, %struct.StatData* %19, i64 0, i32 0, !dbg !480
  store i64 %114, i64* %116, align 8, !dbg !480, !tbaa !282
  %117 = getelementptr inbounds %struct.StatData, %struct.StatData* %19, i64 0, i32 1, !dbg !480
  store i64 %112, i64* %117, align 8, !dbg !480, !tbaa !286
  %118 = getelementptr inbounds %struct.StatData, %struct.StatData* %19, i64 0, i32 2, !dbg !481
  store i64 %113, i64* %118, align 8, !dbg !483, !tbaa !288
  call void @llvm.dbg.value(metadata i32* %18, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !469
  %119 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %98, i8* nonnull %115, i64 0) #4, !dbg !484
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %115) #4, !dbg !485
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %98) #4, !dbg !485
  call void @llvm.lifetime.end.p0i8(i64 14, i8* nonnull %94), !dbg !486
  br label %346

120:                                              ; preds = %65
  call void @llvm.dbg.value(metadata i32 1, metadata !257, metadata !DIExpression()) #4, !dbg !487
  call void @llvm.dbg.value(metadata i32 0, metadata !258, metadata !DIExpression()) #4, !dbg !487
  call void @llvm.dbg.value(metadata i32 0, metadata !259, metadata !DIExpression()) #4, !dbg !487
  %121 = bitcast i32* %16 to i8*, !dbg !488
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %121) #4, !dbg !488
  call void @llvm.dbg.value(metadata i32 0, metadata !260, metadata !DIExpression()) #4, !dbg !487
  store i32 0, i32* %16, align 4, !dbg !489, !tbaa !229
  call void @llvm.dbg.value(metadata i64 0, metadata !261, metadata !DIExpression()) #4, !dbg !487
  call void @llvm.dbg.value(metadata i64 0, metadata !262, metadata !DIExpression()) #4, !dbg !487
  call void @llvm.dbg.value(metadata i64 0, metadata !263, metadata !DIExpression()) #4, !dbg !487
  call void @llvm.dbg.value(metadata i32* %16, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !487
  %122 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %121) #4, !dbg !490
  call void @llvm.dbg.value(metadata i8* %122, metadata !264, metadata !DIExpression()) #4, !dbg !487
  %123 = icmp eq i8* %122, null, !dbg !491
  br i1 %123, label %134, label %124, !dbg !492

124:                                              ; preds = %120
  call void @llvm.dbg.value(metadata i8* %122, metadata !264, metadata !DIExpression()) #4, !dbg !487
  %125 = bitcast i8* %122 to i64*, !dbg !493
  %126 = load i64, i64* %125, align 8, !dbg !493, !tbaa !282
  call void @llvm.dbg.value(metadata i64 %126, metadata !261, metadata !DIExpression()) #4, !dbg !487
  %127 = getelementptr inbounds i8, i8* %122, i64 8, !dbg !494
  %128 = bitcast i8* %127 to i64*, !dbg !494
  %129 = load i64, i64* %128, align 8, !dbg !494, !tbaa !286
  call void @llvm.dbg.value(metadata i64 %129, metadata !262, metadata !DIExpression()) #4, !dbg !487
  %130 = getelementptr inbounds i8, i8* %122, i64 16, !dbg !495
  %131 = bitcast i8* %130 to i64*, !dbg !495
  %132 = load i64, i64* %131, align 8, !dbg !495, !tbaa !288
  call void @llvm.dbg.value(metadata i64 %132, metadata !263, metadata !DIExpression()) #4, !dbg !487
  %133 = add i64 %126, 1, !dbg !496
  br label %134, !dbg !496

134:                                              ; preds = %120, %124
  %135 = phi i64 [ %129, %124 ], [ 0, %120 ], !dbg !487
  %136 = phi i64 [ %132, %124 ], [ 0, %120 ], !dbg !487
  %137 = phi i64 [ %133, %124 ], [ 1, %120 ]
  call void @llvm.dbg.value(metadata i64 undef, metadata !261, metadata !DIExpression()) #4, !dbg !487
  call void @llvm.dbg.value(metadata i64 %136, metadata !263, metadata !DIExpression()) #4, !dbg !487
  call void @llvm.dbg.value(metadata i64 %135, metadata !262, metadata !DIExpression()) #4, !dbg !487
  %138 = bitcast %struct.StatData* %17 to i8*, !dbg !497
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %138) #4, !dbg !497
  %139 = getelementptr inbounds %struct.StatData, %struct.StatData* %17, i64 0, i32 0, !dbg !498
  store i64 %137, i64* %139, align 8, !dbg !499, !tbaa !282
  %140 = getelementptr inbounds %struct.StatData, %struct.StatData* %17, i64 0, i32 1, !dbg !500
  store i64 %135, i64* %140, align 8, !dbg !501, !tbaa !286
  %141 = getelementptr inbounds %struct.StatData, %struct.StatData* %17, i64 0, i32 2, !dbg !502
  store i64 %136, i64* %141, align 8, !dbg !503, !tbaa !288
  call void @llvm.dbg.value(metadata i32* %16, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !487
  %142 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %121, i8* nonnull %138, i64 0) #4, !dbg !504
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %138) #4, !dbg !505
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %121) #4, !dbg !505
  br label %346, !dbg !506

143:                                              ; preds = %55, %61
  %144 = getelementptr inbounds [6 x i8], [6 x i8]* %40, i64 2, !dbg !507
  %145 = bitcast [6 x i8]* %144 to i16*, !dbg !507
  %146 = load i16, i16* %145, align 4, !dbg !507
  %147 = and i16 %146, 512, !dbg !507
  %148 = icmp eq i16 %147, 0, !dbg !508
  br i1 %148, label %235, label %149, !dbg !509

149:                                              ; preds = %143
  %150 = load i32, i32* %57, align 4, !dbg !510, !tbaa !440
  %151 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 2, i32 0, i64 2, !dbg !511
  %152 = bitcast i8* %151 to i32*, !dbg !511
  %153 = load i32, i32* %152, align 4, !dbg !511, !tbaa !459
  %154 = bitcast [6 x i8]* %40 to i16*, !dbg !512
  %155 = load i16, i16* %154, align 4, !dbg !512, !tbaa !453
  %156 = load i16, i16* %52, align 2, !dbg !513, !tbaa !422
  %157 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 2, i32 1, i64 4, !dbg !514
  %158 = bitcast i8* %157 to i32*, !dbg !514
  %159 = load i32, i32* %158, align 4, !dbg !514, !tbaa !446
  %160 = tail call i32 @llvm.bswap.i32(i32 %159), !dbg !514
  %161 = add i32 %160, -1, !dbg !515
  call void @llvm.dbg.value(metadata i32 %150, metadata !172, metadata !DIExpression()) #4, !dbg !516
  call void @llvm.dbg.value(metadata i32 %153, metadata !173, metadata !DIExpression()) #4, !dbg !516
  call void @llvm.dbg.value(metadata i16 %155, metadata !174, metadata !DIExpression()) #4, !dbg !516
  call void @llvm.dbg.value(metadata i16 %156, metadata !175, metadata !DIExpression()) #4, !dbg !516
  call void @llvm.dbg.value(metadata i32 %161, metadata !176, metadata !DIExpression()) #4, !dbg !516
  %162 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !518
  call void @llvm.dbg.value(metadata i64 %162, metadata !150, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #4, !dbg !520
  call void @llvm.dbg.value(metadata i64 %162, metadata !177, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_constu, 1640531527, DW_OP_xor, DW_OP_stack_value)) #4, !dbg !516
  %163 = zext i32 %153 to i64, !dbg !521
  %164 = shl nuw i64 %163, 32, !dbg !522
  %165 = zext i32 %150 to i64, !dbg !523
  %166 = or i64 %164, %165, !dbg !524
  call void @llvm.dbg.value(metadata i64 %166, metadata !161, metadata !DIExpression()) #4, !dbg !525
  call void @llvm.dbg.value(metadata i64 %162, metadata !162, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_constu, 18446744073709520455, DW_OP_xor, DW_OP_stack_value)) #4, !dbg !525
  %167 = mul i64 %166, 1640531527, !dbg !527
  call void @llvm.dbg.value(metadata i64 %167, metadata !163, metadata !DIExpression()) #4, !dbg !525
  %168 = and i64 %162, 65535, !dbg !528
  %169 = xor i64 %168, 34375, !dbg !528
  %170 = lshr i64 %167, %169, !dbg !528
  call void @llvm.dbg.value(metadata i64 %170, metadata !178, metadata !DIExpression()) #4, !dbg !516
  %171 = zext i16 %156 to i64, !dbg !529
  %172 = shl nuw i64 %171, 48, !dbg !530
  %173 = zext i32 %161 to i64, !dbg !531
  %174 = shl nuw nsw i64 %173, 16, !dbg !532
  %175 = zext i16 %155 to i64, !dbg !533
  %176 = or i64 %172, %175, !dbg !534
  %177 = or i64 %176, %174, !dbg !535
  call void @llvm.dbg.value(metadata i64 %177, metadata !161, metadata !DIExpression()) #4, !dbg !536
  call void @llvm.dbg.value(metadata i64 %170, metadata !162, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_stack_value)) #4, !dbg !536
  %178 = mul i64 %177, 1640531527, !dbg !538
  call void @llvm.dbg.value(metadata i64 %178, metadata !163, metadata !DIExpression()) #4, !dbg !536
  %179 = and i64 %170, 65535, !dbg !539
  %180 = lshr i64 %178, %179, !dbg !539
  call void @llvm.dbg.value(metadata i64 %180, metadata !353, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !540
  %181 = load i32, i32* %158, align 4, !dbg !541, !tbaa !446
  %182 = tail call i32 @llvm.bswap.i32(i32 %181), !dbg !541
  %183 = add i32 %182, -1, !dbg !542
  call void @llvm.dbg.value(metadata i64 %180, metadata !208, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #4, !dbg !543
  call void @llvm.dbg.value(metadata i32 %183, metadata !209, metadata !DIExpression()) #4, !dbg !543
  %184 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !545
  call void @llvm.dbg.value(metadata i64 %184, metadata !150, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #4, !dbg !547
  call void @llvm.dbg.value(metadata i64 %184, metadata !210, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_constu, 1640531527, DW_OP_xor, DW_OP_stack_value)) #4, !dbg !543
  %185 = and i64 %180, 4294967295, !dbg !548
  call void @llvm.dbg.value(metadata i64 %185, metadata !161, metadata !DIExpression()) #4, !dbg !549
  call void @llvm.dbg.value(metadata i64 %184, metadata !162, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_constu, 18446744073709520455, DW_OP_xor, DW_OP_stack_value)) #4, !dbg !549
  %186 = mul nuw nsw i64 %185, 1640531527, !dbg !551
  call void @llvm.dbg.value(metadata i64 %186, metadata !163, metadata !DIExpression()) #4, !dbg !549
  %187 = and i64 %184, 65535, !dbg !552
  %188 = xor i64 %187, 34375, !dbg !552
  %189 = lshr i64 %186, %188, !dbg !552
  %190 = trunc i64 %189 to i32, !dbg !553
  %191 = add i32 %183, %190, !dbg !553
  call void @llvm.dbg.value(metadata i32 %191, metadata !357, metadata !DIExpression()), !dbg !540
  %192 = load i32, i32* %57, align 4, !dbg !554, !tbaa !440
  %193 = bitcast i32* %14 to i8*, !dbg !555
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %193), !dbg !555
  %194 = bitcast i32* %15 to i8*, !dbg !555
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %194), !dbg !555
  call void @llvm.dbg.value(metadata i32 %191, metadata !226, metadata !DIExpression()) #4, !dbg !555
  store i32 %191, i32* %14, align 4, !tbaa !229
  call void @llvm.dbg.value(metadata i32 %192, metadata !227, metadata !DIExpression()) #4, !dbg !555
  store i32 %192, i32* %15, align 4, !tbaa !229
  call void @llvm.dbg.value(metadata i32* %14, metadata !226, metadata !DIExpression(DW_OP_deref)) #4, !dbg !555
  call void @llvm.dbg.value(metadata i32* %15, metadata !227, metadata !DIExpression(DW_OP_deref)) #4, !dbg !555
  %195 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @hash_table_map to i8*), i8* nonnull %194, i8* nonnull %193, i64 0) #4, !dbg !557
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %193), !dbg !558
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %194), !dbg !558
  %196 = load i32, i32* %158, align 4, !dbg !559, !tbaa !446
  %197 = call i32 @llvm.bswap.i32(i32 %196), !dbg !559
  %198 = add i32 %197, 1, !dbg !559
  %199 = call i32 @llvm.bswap.i32(i32 %198), !dbg !559
  %200 = getelementptr inbounds [6 x i8], [6 x i8]* %40, i64 1, i64 2, !dbg !560
  %201 = bitcast i8* %200 to i32*, !dbg !560
  store i32 %199, i32* %201, align 4, !dbg !561, !tbaa !449
  %202 = call i32 @llvm.bswap.i32(i32 %191), !dbg !562
  store i32 %202, i32* %158, align 4, !dbg !563, !tbaa !446
  %203 = load i16, i16* %145, align 4, !dbg !564
  %204 = or i16 %203, 4096, !dbg !564
  store i16 %204, i16* %145, align 4, !dbg !564
  %205 = load i16, i16* %154, align 4, !dbg !565, !tbaa !453
  call void @llvm.dbg.value(metadata i16 %205, metadata !358, metadata !DIExpression()), !dbg !540
  %206 = load i16, i16* %52, align 2, !dbg !566, !tbaa !422
  store i16 %206, i16* %154, align 4, !dbg !567, !tbaa !453
  store i16 %205, i16* %52, align 2, !dbg !568, !tbaa !422
  %207 = load i32, i32* %57, align 4, !dbg !569, !tbaa !440
  call void @llvm.dbg.value(metadata i32 %207, metadata !359, metadata !DIExpression()), !dbg !540
  %208 = load i32, i32* %152, align 4, !dbg !570, !tbaa !459
  store i32 %208, i32* %57, align 4, !dbg !571, !tbaa !440
  store i32 %207, i32* %152, align 4, !dbg !572, !tbaa !459
  %209 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %23, i64 0, i32 0, i64 0, !dbg !573
  call void @llvm.lifetime.start.p0i8(i64 14, i8* nonnull %209), !dbg !573
  call void @llvm.dbg.declare(metadata %struct.ethhdr* %23, metadata !360, metadata !DIExpression()), !dbg !574
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(14) %209, i8* nonnull align 1 dereferenceable(14) %27, i64 14, i1 false), !dbg !575, !tbaa.struct !465
  %210 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 0, i32 0, i64 0, !dbg !576
  %211 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %23, i64 0, i32 1, i64 0, !dbg !576
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %210, i8* nonnull align 1 dereferenceable(6) %211, i64 6, i1 false), !dbg !576
  %212 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %28, i64 0, i32 1, i64 0, !dbg !577
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %212, i8* nonnull align 1 dereferenceable(6) %209, i64 6, i1 false), !dbg !577
  call void @llvm.dbg.value(metadata i32 0, metadata !257, metadata !DIExpression()) #4, !dbg !578
  call void @llvm.dbg.value(metadata i32 0, metadata !258, metadata !DIExpression()) #4, !dbg !578
  call void @llvm.dbg.value(metadata i32 1, metadata !259, metadata !DIExpression()) #4, !dbg !578
  %213 = bitcast i32* %12 to i8*, !dbg !579
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %213) #4, !dbg !579
  call void @llvm.dbg.value(metadata i32 0, metadata !260, metadata !DIExpression()) #4, !dbg !578
  store i32 0, i32* %12, align 4, !dbg !580, !tbaa !229
  call void @llvm.dbg.value(metadata i64 0, metadata !261, metadata !DIExpression()) #4, !dbg !578
  call void @llvm.dbg.value(metadata i64 0, metadata !262, metadata !DIExpression()) #4, !dbg !578
  call void @llvm.dbg.value(metadata i64 0, metadata !263, metadata !DIExpression()) #4, !dbg !578
  call void @llvm.dbg.value(metadata i32* %12, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !578
  %214 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %213) #4, !dbg !581
  call void @llvm.dbg.value(metadata i8* %214, metadata !264, metadata !DIExpression()) #4, !dbg !578
  %215 = icmp eq i8* %214, null, !dbg !582
  br i1 %215, label %226, label %216, !dbg !583

216:                                              ; preds = %149
  call void @llvm.dbg.value(metadata i8* %214, metadata !264, metadata !DIExpression()) #4, !dbg !578
  %217 = bitcast i8* %214 to i64*, !dbg !584
  %218 = load i64, i64* %217, align 8, !dbg !584, !tbaa !282
  call void @llvm.dbg.value(metadata i64 %218, metadata !261, metadata !DIExpression()) #4, !dbg !578
  %219 = getelementptr inbounds i8, i8* %214, i64 8, !dbg !585
  %220 = bitcast i8* %219 to i64*, !dbg !585
  %221 = load i64, i64* %220, align 8, !dbg !585, !tbaa !286
  call void @llvm.dbg.value(metadata i64 %221, metadata !262, metadata !DIExpression()) #4, !dbg !578
  %222 = getelementptr inbounds i8, i8* %214, i64 16, !dbg !586
  %223 = bitcast i8* %222 to i64*, !dbg !586
  %224 = load i64, i64* %223, align 8, !dbg !586, !tbaa !288
  call void @llvm.dbg.value(metadata i64 %224, metadata !263, metadata !DIExpression()) #4, !dbg !578
  %225 = add i64 %224, 1, !dbg !587
  br label %226, !dbg !587

226:                                              ; preds = %149, %216
  %227 = phi i64 [ %221, %216 ], [ 0, %149 ], !dbg !578
  %228 = phi i64 [ %225, %216 ], [ 1, %149 ]
  %229 = phi i64 [ %218, %216 ], [ 0, %149 ], !dbg !578
  call void @llvm.dbg.value(metadata i64 %229, metadata !261, metadata !DIExpression()) #4, !dbg !578
  call void @llvm.dbg.value(metadata i64 undef, metadata !263, metadata !DIExpression()) #4, !dbg !578
  call void @llvm.dbg.value(metadata i64 %227, metadata !262, metadata !DIExpression()) #4, !dbg !578
  %230 = bitcast %struct.StatData* %13 to i8*, !dbg !588
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %230) #4, !dbg !588
  %231 = getelementptr inbounds %struct.StatData, %struct.StatData* %13, i64 0, i32 0, !dbg !589
  store i64 %229, i64* %231, align 8, !dbg !589, !tbaa !282
  %232 = getelementptr inbounds %struct.StatData, %struct.StatData* %13, i64 0, i32 1, !dbg !589
  store i64 %227, i64* %232, align 8, !dbg !589, !tbaa !286
  %233 = getelementptr inbounds %struct.StatData, %struct.StatData* %13, i64 0, i32 2, !dbg !590
  store i64 %228, i64* %233, align 8, !dbg !591, !tbaa !288
  call void @llvm.dbg.value(metadata i32* %12, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !578
  %234 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %213, i8* nonnull %230, i64 0) #4, !dbg !592
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %230) #4, !dbg !593
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %213) #4, !dbg !593
  call void @llvm.lifetime.end.p0i8(i64 14, i8* nonnull %209), !dbg !594
  br label %346

235:                                              ; preds = %143
  %236 = and i16 %146, 4096, !dbg !595
  %237 = icmp eq i16 %236, 0, !dbg !596
  br i1 %237, label %323, label %238, !dbg !597

238:                                              ; preds = %235
  %239 = tail call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @hash_table_map to i8*), i8* nonnull %58) #4, !dbg !598
  call void @llvm.dbg.value(metadata i8* %239, metadata !361, metadata !DIExpression()), !dbg !599
  %240 = icmp eq i8* %239, null, !dbg !600
  br i1 %240, label %300, label %241, !dbg !601

241:                                              ; preds = %238
  %242 = bitcast i8* %239 to i32*, !dbg !598
  call void @llvm.dbg.value(metadata i32* %242, metadata !361, metadata !DIExpression()), !dbg !599
  %243 = getelementptr inbounds [6 x i8], [6 x i8]* %40, i64 1, i64 2, !dbg !602
  %244 = bitcast i8* %243 to i32*, !dbg !602
  %245 = load i32, i32* %244, align 4, !dbg !602, !tbaa !449
  %246 = tail call i32 @llvm.bswap.i32(i32 %245), !dbg !602
  %247 = add i32 %246, -1, !dbg !603
  call void @llvm.dbg.value(metadata i32 %247, metadata !365, metadata !DIExpression()), !dbg !604
  %248 = load i32, i32* %242, align 4, !dbg !605, !tbaa !229
  %249 = icmp eq i32 %247, %248, !dbg !606
  br i1 %249, label %250, label %277, !dbg !607

250:                                              ; preds = %241
  call void @llvm.dbg.value(metadata i16 100, metadata !368, metadata !DIExpression()), !dbg !608
  %251 = load i32, i32* %57, align 4, !dbg !609, !tbaa !440
  %252 = bitcast i16* %10 to i8*, !dbg !610
  call void @llvm.lifetime.start.p0i8(i64 2, i8* nonnull %252), !dbg !610
  %253 = bitcast i32* %11 to i8*, !dbg !610
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %253), !dbg !610
  call void @llvm.dbg.value(metadata i16 100, metadata !243, metadata !DIExpression()) #4, !dbg !610
  store i16 100, i16* %10, align 2, !tbaa !246
  call void @llvm.dbg.value(metadata i32 %251, metadata !244, metadata !DIExpression()) #4, !dbg !610
  store i32 %251, i32* %11, align 4, !tbaa !229
  call void @llvm.dbg.value(metadata i16* %10, metadata !243, metadata !DIExpression(DW_OP_deref)) #4, !dbg !610
  call void @llvm.dbg.value(metadata i32* %11, metadata !244, metadata !DIExpression(DW_OP_deref)) #4, !dbg !610
  %254 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @white_table_map to i8*), i8* nonnull %253, i8* nonnull %252, i64 0) #4, !dbg !612
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %252), !dbg !613
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %253), !dbg !613
  call void @llvm.dbg.value(metadata i32 1, metadata !257, metadata !DIExpression()) #4, !dbg !614
  call void @llvm.dbg.value(metadata i32 0, metadata !258, metadata !DIExpression()) #4, !dbg !614
  call void @llvm.dbg.value(metadata i32 0, metadata !259, metadata !DIExpression()) #4, !dbg !614
  %255 = bitcast i32* %8 to i8*, !dbg !615
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %255) #4, !dbg !615
  call void @llvm.dbg.value(metadata i32 0, metadata !260, metadata !DIExpression()) #4, !dbg !614
  store i32 0, i32* %8, align 4, !dbg !616, !tbaa !229
  call void @llvm.dbg.value(metadata i64 0, metadata !261, metadata !DIExpression()) #4, !dbg !614
  call void @llvm.dbg.value(metadata i64 0, metadata !262, metadata !DIExpression()) #4, !dbg !614
  call void @llvm.dbg.value(metadata i64 0, metadata !263, metadata !DIExpression()) #4, !dbg !614
  call void @llvm.dbg.value(metadata i32* %8, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !614
  %256 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %255) #4, !dbg !617
  call void @llvm.dbg.value(metadata i8* %256, metadata !264, metadata !DIExpression()) #4, !dbg !614
  %257 = icmp eq i8* %256, null, !dbg !618
  br i1 %257, label %268, label %258, !dbg !619

258:                                              ; preds = %250
  call void @llvm.dbg.value(metadata i8* %256, metadata !264, metadata !DIExpression()) #4, !dbg !614
  %259 = bitcast i8* %256 to i64*, !dbg !620
  %260 = load i64, i64* %259, align 8, !dbg !620, !tbaa !282
  call void @llvm.dbg.value(metadata i64 %260, metadata !261, metadata !DIExpression()) #4, !dbg !614
  %261 = getelementptr inbounds i8, i8* %256, i64 8, !dbg !621
  %262 = bitcast i8* %261 to i64*, !dbg !621
  %263 = load i64, i64* %262, align 8, !dbg !621, !tbaa !286
  call void @llvm.dbg.value(metadata i64 %263, metadata !262, metadata !DIExpression()) #4, !dbg !614
  %264 = getelementptr inbounds i8, i8* %256, i64 16, !dbg !622
  %265 = bitcast i8* %264 to i64*, !dbg !622
  %266 = load i64, i64* %265, align 8, !dbg !622, !tbaa !288
  call void @llvm.dbg.value(metadata i64 %266, metadata !263, metadata !DIExpression()) #4, !dbg !614
  %267 = add i64 %260, 1, !dbg !623
  br label %268, !dbg !623

268:                                              ; preds = %250, %258
  %269 = phi i64 [ %263, %258 ], [ 0, %250 ], !dbg !614
  %270 = phi i64 [ %266, %258 ], [ 0, %250 ], !dbg !614
  %271 = phi i64 [ %267, %258 ], [ 1, %250 ]
  call void @llvm.dbg.value(metadata i64 undef, metadata !261, metadata !DIExpression()) #4, !dbg !614
  call void @llvm.dbg.value(metadata i64 %270, metadata !263, metadata !DIExpression()) #4, !dbg !614
  call void @llvm.dbg.value(metadata i64 %269, metadata !262, metadata !DIExpression()) #4, !dbg !614
  %272 = bitcast %struct.StatData* %9 to i8*, !dbg !624
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %272) #4, !dbg !624
  %273 = getelementptr inbounds %struct.StatData, %struct.StatData* %9, i64 0, i32 0, !dbg !625
  store i64 %271, i64* %273, align 8, !dbg !626, !tbaa !282
  %274 = getelementptr inbounds %struct.StatData, %struct.StatData* %9, i64 0, i32 1, !dbg !627
  store i64 %269, i64* %274, align 8, !dbg !628, !tbaa !286
  %275 = getelementptr inbounds %struct.StatData, %struct.StatData* %9, i64 0, i32 2, !dbg !629
  store i64 %270, i64* %275, align 8, !dbg !630, !tbaa !288
  call void @llvm.dbg.value(metadata i32* %8, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !614
  %276 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %255, i8* nonnull %272, i64 0) #4, !dbg !631
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %272) #4, !dbg !632
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %255) #4, !dbg !632
  br label %346

277:                                              ; preds = %241
  call void @llvm.dbg.value(metadata i32 0, metadata !257, metadata !DIExpression()) #4, !dbg !633
  call void @llvm.dbg.value(metadata i32 1, metadata !258, metadata !DIExpression()) #4, !dbg !633
  call void @llvm.dbg.value(metadata i32 0, metadata !259, metadata !DIExpression()) #4, !dbg !633
  %278 = bitcast i32* %6 to i8*, !dbg !634
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %278) #4, !dbg !634
  call void @llvm.dbg.value(metadata i32 0, metadata !260, metadata !DIExpression()) #4, !dbg !633
  store i32 0, i32* %6, align 4, !dbg !635, !tbaa !229
  call void @llvm.dbg.value(metadata i64 0, metadata !261, metadata !DIExpression()) #4, !dbg !633
  call void @llvm.dbg.value(metadata i64 0, metadata !262, metadata !DIExpression()) #4, !dbg !633
  call void @llvm.dbg.value(metadata i64 0, metadata !263, metadata !DIExpression()) #4, !dbg !633
  call void @llvm.dbg.value(metadata i32* %6, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !633
  %279 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %278) #4, !dbg !636
  call void @llvm.dbg.value(metadata i8* %279, metadata !264, metadata !DIExpression()) #4, !dbg !633
  %280 = icmp eq i8* %279, null, !dbg !637
  br i1 %280, label %291, label %281, !dbg !638

281:                                              ; preds = %277
  call void @llvm.dbg.value(metadata i8* %279, metadata !264, metadata !DIExpression()) #4, !dbg !633
  %282 = bitcast i8* %279 to i64*, !dbg !639
  %283 = load i64, i64* %282, align 8, !dbg !639, !tbaa !282
  call void @llvm.dbg.value(metadata i64 %283, metadata !261, metadata !DIExpression()) #4, !dbg !633
  %284 = getelementptr inbounds i8, i8* %279, i64 8, !dbg !640
  %285 = bitcast i8* %284 to i64*, !dbg !640
  %286 = load i64, i64* %285, align 8, !dbg !640, !tbaa !286
  call void @llvm.dbg.value(metadata i64 %286, metadata !262, metadata !DIExpression()) #4, !dbg !633
  %287 = getelementptr inbounds i8, i8* %279, i64 16, !dbg !641
  %288 = bitcast i8* %287 to i64*, !dbg !641
  %289 = load i64, i64* %288, align 8, !dbg !641, !tbaa !288
  call void @llvm.dbg.value(metadata i64 %289, metadata !263, metadata !DIExpression()) #4, !dbg !633
  %290 = add i64 %286, 1, !dbg !642
  br label %291, !dbg !642

291:                                              ; preds = %277, %281
  %292 = phi i64 [ %290, %281 ], [ 1, %277 ]
  %293 = phi i64 [ %289, %281 ], [ 0, %277 ], !dbg !633
  %294 = phi i64 [ %283, %281 ], [ 0, %277 ], !dbg !633
  call void @llvm.dbg.value(metadata i64 %294, metadata !261, metadata !DIExpression()) #4, !dbg !633
  call void @llvm.dbg.value(metadata i64 %293, metadata !263, metadata !DIExpression()) #4, !dbg !633
  call void @llvm.dbg.value(metadata i64 undef, metadata !262, metadata !DIExpression()) #4, !dbg !633
  %295 = bitcast %struct.StatData* %7 to i8*, !dbg !643
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %295) #4, !dbg !643
  %296 = getelementptr inbounds %struct.StatData, %struct.StatData* %7, i64 0, i32 0, !dbg !644
  store i64 %294, i64* %296, align 8, !dbg !645, !tbaa !282
  %297 = getelementptr inbounds %struct.StatData, %struct.StatData* %7, i64 0, i32 1, !dbg !646
  store i64 %292, i64* %297, align 8, !dbg !647, !tbaa !286
  %298 = getelementptr inbounds %struct.StatData, %struct.StatData* %7, i64 0, i32 2, !dbg !648
  store i64 %293, i64* %298, align 8, !dbg !649, !tbaa !288
  call void @llvm.dbg.value(metadata i32* %6, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !633
  %299 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %278, i8* nonnull %295, i64 0) #4, !dbg !650
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %295) #4, !dbg !651
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %278) #4, !dbg !651
  br label %346, !dbg !652

300:                                              ; preds = %238
  call void @llvm.dbg.value(metadata i32 0, metadata !257, metadata !DIExpression()) #4, !dbg !653
  call void @llvm.dbg.value(metadata i32 1, metadata !258, metadata !DIExpression()) #4, !dbg !653
  call void @llvm.dbg.value(metadata i32 0, metadata !259, metadata !DIExpression()) #4, !dbg !653
  %301 = bitcast i32* %4 to i8*, !dbg !654
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %301) #4, !dbg !654
  call void @llvm.dbg.value(metadata i32 0, metadata !260, metadata !DIExpression()) #4, !dbg !653
  store i32 0, i32* %4, align 4, !dbg !655, !tbaa !229
  call void @llvm.dbg.value(metadata i64 0, metadata !261, metadata !DIExpression()) #4, !dbg !653
  call void @llvm.dbg.value(metadata i64 0, metadata !262, metadata !DIExpression()) #4, !dbg !653
  call void @llvm.dbg.value(metadata i64 0, metadata !263, metadata !DIExpression()) #4, !dbg !653
  call void @llvm.dbg.value(metadata i32* %4, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !653
  %302 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %301) #4, !dbg !656
  call void @llvm.dbg.value(metadata i8* %302, metadata !264, metadata !DIExpression()) #4, !dbg !653
  %303 = icmp eq i8* %302, null, !dbg !657
  br i1 %303, label %314, label %304, !dbg !658

304:                                              ; preds = %300
  call void @llvm.dbg.value(metadata i8* %302, metadata !264, metadata !DIExpression()) #4, !dbg !653
  %305 = bitcast i8* %302 to i64*, !dbg !659
  %306 = load i64, i64* %305, align 8, !dbg !659, !tbaa !282
  call void @llvm.dbg.value(metadata i64 %306, metadata !261, metadata !DIExpression()) #4, !dbg !653
  %307 = getelementptr inbounds i8, i8* %302, i64 8, !dbg !660
  %308 = bitcast i8* %307 to i64*, !dbg !660
  %309 = load i64, i64* %308, align 8, !dbg !660, !tbaa !286
  call void @llvm.dbg.value(metadata i64 %309, metadata !262, metadata !DIExpression()) #4, !dbg !653
  %310 = getelementptr inbounds i8, i8* %302, i64 16, !dbg !661
  %311 = bitcast i8* %310 to i64*, !dbg !661
  %312 = load i64, i64* %311, align 8, !dbg !661, !tbaa !288
  call void @llvm.dbg.value(metadata i64 %312, metadata !263, metadata !DIExpression()) #4, !dbg !653
  %313 = add i64 %309, 1, !dbg !662
  br label %314, !dbg !662

314:                                              ; preds = %300, %304
  %315 = phi i64 [ %313, %304 ], [ 1, %300 ]
  %316 = phi i64 [ %312, %304 ], [ 0, %300 ], !dbg !653
  %317 = phi i64 [ %306, %304 ], [ 0, %300 ], !dbg !653
  call void @llvm.dbg.value(metadata i64 %317, metadata !261, metadata !DIExpression()) #4, !dbg !653
  call void @llvm.dbg.value(metadata i64 %316, metadata !263, metadata !DIExpression()) #4, !dbg !653
  call void @llvm.dbg.value(metadata i64 undef, metadata !262, metadata !DIExpression()) #4, !dbg !653
  %318 = bitcast %struct.StatData* %5 to i8*, !dbg !663
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %318) #4, !dbg !663
  %319 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 0, !dbg !664
  store i64 %317, i64* %319, align 8, !dbg !665, !tbaa !282
  %320 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 1, !dbg !666
  store i64 %315, i64* %320, align 8, !dbg !667, !tbaa !286
  %321 = getelementptr inbounds %struct.StatData, %struct.StatData* %5, i64 0, i32 2, !dbg !668
  store i64 %316, i64* %321, align 8, !dbg !669, !tbaa !288
  call void @llvm.dbg.value(metadata i32* %4, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !653
  %322 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %301, i8* nonnull %318, i64 0) #4, !dbg !670
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %318) #4, !dbg !671
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %301) #4, !dbg !671
  br label %346, !dbg !672

323:                                              ; preds = %235
  call void @llvm.dbg.value(metadata i32 1, metadata !257, metadata !DIExpression()) #4, !dbg !673
  call void @llvm.dbg.value(metadata i32 0, metadata !258, metadata !DIExpression()) #4, !dbg !673
  call void @llvm.dbg.value(metadata i32 0, metadata !259, metadata !DIExpression()) #4, !dbg !673
  %324 = bitcast i32* %2 to i8*, !dbg !674
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %324) #4, !dbg !674
  call void @llvm.dbg.value(metadata i32 0, metadata !260, metadata !DIExpression()) #4, !dbg !673
  store i32 0, i32* %2, align 4, !dbg !675, !tbaa !229
  call void @llvm.dbg.value(metadata i64 0, metadata !261, metadata !DIExpression()) #4, !dbg !673
  call void @llvm.dbg.value(metadata i64 0, metadata !262, metadata !DIExpression()) #4, !dbg !673
  call void @llvm.dbg.value(metadata i64 0, metadata !263, metadata !DIExpression()) #4, !dbg !673
  call void @llvm.dbg.value(metadata i32* %2, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !673
  %325 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %324) #4, !dbg !676
  call void @llvm.dbg.value(metadata i8* %325, metadata !264, metadata !DIExpression()) #4, !dbg !673
  %326 = icmp eq i8* %325, null, !dbg !677
  br i1 %326, label %337, label %327, !dbg !678

327:                                              ; preds = %323
  call void @llvm.dbg.value(metadata i8* %325, metadata !264, metadata !DIExpression()) #4, !dbg !673
  %328 = bitcast i8* %325 to i64*, !dbg !679
  %329 = load i64, i64* %328, align 8, !dbg !679, !tbaa !282
  call void @llvm.dbg.value(metadata i64 %329, metadata !261, metadata !DIExpression()) #4, !dbg !673
  %330 = getelementptr inbounds i8, i8* %325, i64 8, !dbg !680
  %331 = bitcast i8* %330 to i64*, !dbg !680
  %332 = load i64, i64* %331, align 8, !dbg !680, !tbaa !286
  call void @llvm.dbg.value(metadata i64 %332, metadata !262, metadata !DIExpression()) #4, !dbg !673
  %333 = getelementptr inbounds i8, i8* %325, i64 16, !dbg !681
  %334 = bitcast i8* %333 to i64*, !dbg !681
  %335 = load i64, i64* %334, align 8, !dbg !681, !tbaa !288
  call void @llvm.dbg.value(metadata i64 %335, metadata !263, metadata !DIExpression()) #4, !dbg !673
  %336 = add i64 %329, 1, !dbg !682
  br label %337, !dbg !682

337:                                              ; preds = %323, %327
  %338 = phi i64 [ %332, %327 ], [ 0, %323 ], !dbg !673
  %339 = phi i64 [ %335, %327 ], [ 0, %323 ], !dbg !673
  %340 = phi i64 [ %336, %327 ], [ 1, %323 ]
  call void @llvm.dbg.value(metadata i64 undef, metadata !261, metadata !DIExpression()) #4, !dbg !673
  call void @llvm.dbg.value(metadata i64 %339, metadata !263, metadata !DIExpression()) #4, !dbg !673
  call void @llvm.dbg.value(metadata i64 %338, metadata !262, metadata !DIExpression()) #4, !dbg !673
  %341 = bitcast %struct.StatData* %3 to i8*, !dbg !683
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %341) #4, !dbg !683
  %342 = getelementptr inbounds %struct.StatData, %struct.StatData* %3, i64 0, i32 0, !dbg !684
  store i64 %340, i64* %342, align 8, !dbg !685, !tbaa !282
  %343 = getelementptr inbounds %struct.StatData, %struct.StatData* %3, i64 0, i32 1, !dbg !686
  store i64 %338, i64* %343, align 8, !dbg !687, !tbaa !286
  %344 = getelementptr inbounds %struct.StatData, %struct.StatData* %3, i64 0, i32 2, !dbg !688
  store i64 %339, i64* %344, align 8, !dbg !689, !tbaa !288
  call void @llvm.dbg.value(metadata i32* %2, metadata !260, metadata !DIExpression(DW_OP_deref)) #4, !dbg !673
  %345 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @stat_map to i8*), i8* nonnull %324, i8* nonnull %341, i64 0) #4, !dbg !690
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %341) #4, !dbg !691
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %324) #4, !dbg !691
  br label %346, !dbg !692

346:                                              ; preds = %50, %39, %43, %111, %134, %226, %337, %268, %291, %314, %47, %35, %1
  %347 = phi i32 [ 2, %1 ], [ 2, %35 ], [ 1, %39 ], [ 2, %43 ], [ 1, %47 ], [ 3, %111 ], [ 2, %134 ], [ 3, %226 ], [ 2, %337 ], [ 1, %314 ], [ 2, %268 ], [ 1, %291 ], [ 1, %50 ], !dbg !387
  ret i32 %347, !dbg !693
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { norecurse nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!141, !142, !143}
!llvm.ident = !{!144}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "hash_table_map", scope: !2, file: !3, line: 28, type: !106, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !43, globals: !103, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_kern.c", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/XDP_syn_cookie")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/XDP_syn_cookie")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !15, line: 28, baseType: !7, size: 32, elements: !16)
!15 = !DIFile(filename: "/usr/include/linux/in.h", directory: "")
!16 = !{!17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42}
!17 = !DIEnumerator(name: "IPPROTO_IP", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1, isUnsigned: true)
!19 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2, isUnsigned: true)
!20 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4, isUnsigned: true)
!21 = !DIEnumerator(name: "IPPROTO_TCP", value: 6, isUnsigned: true)
!22 = !DIEnumerator(name: "IPPROTO_EGP", value: 8, isUnsigned: true)
!23 = !DIEnumerator(name: "IPPROTO_PUP", value: 12, isUnsigned: true)
!24 = !DIEnumerator(name: "IPPROTO_UDP", value: 17, isUnsigned: true)
!25 = !DIEnumerator(name: "IPPROTO_IDP", value: 22, isUnsigned: true)
!26 = !DIEnumerator(name: "IPPROTO_TP", value: 29, isUnsigned: true)
!27 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33, isUnsigned: true)
!28 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41, isUnsigned: true)
!29 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46, isUnsigned: true)
!30 = !DIEnumerator(name: "IPPROTO_GRE", value: 47, isUnsigned: true)
!31 = !DIEnumerator(name: "IPPROTO_ESP", value: 50, isUnsigned: true)
!32 = !DIEnumerator(name: "IPPROTO_AH", value: 51, isUnsigned: true)
!33 = !DIEnumerator(name: "IPPROTO_MTP", value: 92, isUnsigned: true)
!34 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94, isUnsigned: true)
!35 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98, isUnsigned: true)
!36 = !DIEnumerator(name: "IPPROTO_PIM", value: 103, isUnsigned: true)
!37 = !DIEnumerator(name: "IPPROTO_COMP", value: 108, isUnsigned: true)
!38 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132, isUnsigned: true)
!39 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136, isUnsigned: true)
!40 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137, isUnsigned: true)
!41 = !DIEnumerator(name: "IPPROTO_RAW", value: 255, isUnsigned: true)
!42 = !DIEnumerator(name: "IPPROTO_MAX", value: 256, isUnsigned: true)
!43 = !{!44, !47, !48, !63, !61, !64, !82}
!44 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !45, line: 31, baseType: !46)
!45 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!46 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!47 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !45, line: 27, baseType: !7)
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!49 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !50, line: 163, size: 112, elements: !51)
!50 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!51 = !{!52, !57, !58}
!52 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !49, file: !50, line: 164, baseType: !53, size: 48)
!53 = !DICompositeType(tag: DW_TAG_array_type, baseType: !54, size: 48, elements: !55)
!54 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!55 = !{!56}
!56 = !DISubrange(count: 6)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !49, file: !50, line: 165, baseType: !53, size: 48, offset: 48)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !49, file: !50, line: 166, baseType: !59, size: 16, offset: 96)
!59 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !60, line: 25, baseType: !61)
!60 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!61 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !45, line: 24, baseType: !62)
!62 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !66, line: 86, size: 160, elements: !67)
!66 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!67 = !{!68, !70, !71, !72, !73, !74, !75, !76, !77, !79, !81}
!68 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !65, file: !66, line: 88, baseType: !69, size: 4, flags: DIFlagBitField, extraData: i64 0)
!69 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !45, line: 21, baseType: !54)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !65, file: !66, line: 89, baseType: !69, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !65, file: !66, line: 96, baseType: !69, size: 8, offset: 8)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !65, file: !66, line: 97, baseType: !59, size: 16, offset: 16)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !65, file: !66, line: 98, baseType: !59, size: 16, offset: 32)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !65, file: !66, line: 99, baseType: !59, size: 16, offset: 48)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !65, file: !66, line: 100, baseType: !69, size: 8, offset: 64)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !65, file: !66, line: 101, baseType: !69, size: 8, offset: 72)
!77 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !65, file: !66, line: 102, baseType: !78, size: 16, offset: 80)
!78 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !60, line: 31, baseType: !61)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !65, file: !66, line: 103, baseType: !80, size: 32, offset: 96)
!80 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !60, line: 27, baseType: !47)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !65, file: !66, line: 104, baseType: !80, size: 32, offset: 128)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !84, line: 25, size: 160, elements: !85)
!84 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!85 = !{!86, !87, !88, !89, !90, !91, !92, !93, !94, !95, !96, !97, !98, !99, !100, !101, !102}
!86 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !83, file: !84, line: 26, baseType: !59, size: 16)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !83, file: !84, line: 27, baseType: !59, size: 16, offset: 16)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !83, file: !84, line: 28, baseType: !80, size: 32, offset: 32)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !83, file: !84, line: 29, baseType: !80, size: 32, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !83, file: !84, line: 31, baseType: !61, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !83, file: !84, line: 32, baseType: !61, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !83, file: !84, line: 33, baseType: !61, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !83, file: !84, line: 34, baseType: !61, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !83, file: !84, line: 35, baseType: !61, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !83, file: !84, line: 36, baseType: !61, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !83, file: !84, line: 37, baseType: !61, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !83, file: !84, line: 38, baseType: !61, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !83, file: !84, line: 39, baseType: !61, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !83, file: !84, line: 40, baseType: !61, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !83, file: !84, line: 55, baseType: !59, size: 16, offset: 112)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !83, file: !84, line: 56, baseType: !78, size: 16, offset: 128)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !83, file: !84, line: 57, baseType: !59, size: 16, offset: 144)
!103 = !{!0, !104, !114, !116, !122, !128, !136}
!104 = !DIGlobalVariableExpression(var: !105, expr: !DIExpression())
!105 = distinct !DIGlobalVariable(name: "white_table_map", scope: !2, file: !3, line: 37, type: !106, isLocal: false, isDefinition: true)
!106 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !107, line: 154, size: 160, elements: !108)
!107 = !DIFile(filename: "/usr/include/bpf/bpf_helpers.h", directory: "")
!108 = !{!109, !110, !111, !112, !113}
!109 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !106, file: !107, line: 155, baseType: !7, size: 32)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !106, file: !107, line: 156, baseType: !7, size: 32, offset: 32)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !106, file: !107, line: 157, baseType: !7, size: 32, offset: 64)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !106, file: !107, line: 158, baseType: !7, size: 32, offset: 96)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !106, file: !107, line: 159, baseType: !7, size: 32, offset: 128)
!114 = !DIGlobalVariableExpression(var: !115, expr: !DIExpression())
!115 = distinct !DIGlobalVariable(name: "stat_map", scope: !2, file: !3, line: 46, type: !106, isLocal: false, isDefinition: true)
!116 = !DIGlobalVariableExpression(var: !117, expr: !DIExpression())
!117 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 269, type: !118, isLocal: false, isDefinition: true)
!118 = !DICompositeType(tag: DW_TAG_array_type, baseType: !119, size: 32, elements: !120)
!119 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!120 = !{!121}
!121 = !DISubrange(count: 4)
!122 = !DIGlobalVariableExpression(var: !123, expr: !DIExpression())
!123 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !124, line: 109, type: !125, isLocal: true, isDefinition: true)
!124 = !DIFile(filename: "/usr/include/bpf/bpf_helper_defs.h", directory: "")
!125 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !126, size: 64)
!126 = !DISubroutineType(types: !127)
!127 = !{!44}
!128 = !DIGlobalVariableExpression(var: !129, expr: !DIExpression())
!129 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !124, line: 73, type: !130, isLocal: true, isDefinition: true)
!130 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !131, size: 64)
!131 = !DISubroutineType(types: !132)
!132 = !{!133, !63, !134, !134, !44}
!133 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!134 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !135, size: 64)
!135 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!136 = !DIGlobalVariableExpression(var: !137, expr: !DIExpression())
!137 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !124, line: 51, type: !138, isLocal: true, isDefinition: true)
!138 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !139, size: 64)
!139 = !DISubroutineType(types: !140)
!140 = !{!63, !63, !134}
!141 = !{i32 7, !"Dwarf Version", i32 4}
!142 = !{i32 2, !"Debug Info Version", i32 3}
!143 = !{i32 1, !"wchar_size", i32 4}
!144 = !{!"clang version 10.0.0-4ubuntu1 "}
!145 = distinct !DISubprogram(name: "get_seed", scope: !146, file: !146, line: 11, type: !147, scopeLine: 11, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !149)
!146 = !DIFile(filename: "./hash_cookie.h", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/XDP_syn_cookie")
!147 = !DISubroutineType(types: !148)
!148 = !{!47}
!149 = !{!150}
!150 = !DILocalVariable(name: "sec", scope: !145, file: !146, line: 12, type: !47)
!151 = !DILocation(line: 12, column: 18, scope: !145)
!152 = !DILocation(line: 12, column: 17, scope: !145)
!153 = !DILocation(line: 0, scope: !145)
!154 = !DILocation(line: 15, column: 16, scope: !145)
!155 = !DILocation(line: 15, column: 5, scope: !145)
!156 = distinct !DISubprogram(name: "hash_sum", scope: !146, file: !146, line: 20, type: !157, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !160)
!157 = !DISubroutineType(types: !158)
!158 = !{!44, !159, !61}
!159 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !44)
!160 = !{!161, !162, !163}
!161 = !DILocalVariable(name: "buf", arg: 1, scope: !156, file: !146, line: 20, type: !159)
!162 = !DILocalVariable(name: "sid", arg: 2, scope: !156, file: !146, line: 20, type: !61)
!163 = !DILocalVariable(name: "hash", scope: !156, file: !146, line: 21, type: !44)
!164 = !DILocation(line: 0, scope: !156)
!165 = !DILocation(line: 21, column: 22, scope: !156)
!166 = !DILocation(line: 22, column: 17, scope: !156)
!167 = !DILocation(line: 22, column: 5, scope: !156)
!168 = distinct !DISubprogram(name: "hash_tcp_ip", scope: !146, file: !146, line: 27, type: !169, scopeLine: 27, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !171)
!169 = !DISubroutineType(types: !170)
!170 = !{!47, !47, !47, !61, !61, !47}
!171 = !{!172, !173, !174, !175, !176, !177, !178}
!172 = !DILocalVariable(name: "saddr", arg: 1, scope: !168, file: !146, line: 27, type: !47)
!173 = !DILocalVariable(name: "daddr", arg: 2, scope: !168, file: !146, line: 27, type: !47)
!174 = !DILocalVariable(name: "sport", arg: 3, scope: !168, file: !146, line: 27, type: !61)
!175 = !DILocalVariable(name: "dport", arg: 4, scope: !168, file: !146, line: 27, type: !61)
!176 = !DILocalVariable(name: "seqnum", arg: 5, scope: !168, file: !146, line: 27, type: !47)
!177 = !DILocalVariable(name: "cookie_seed", scope: !168, file: !146, line: 28, type: !47)
!178 = !DILocalVariable(name: "res", scope: !168, file: !146, line: 30, type: !44)
!179 = !DILocation(line: 0, scope: !168)
!180 = !DILocation(line: 12, column: 18, scope: !145, inlinedAt: !181)
!181 = distinct !DILocation(line: 28, column: 25, scope: !168)
!182 = !DILocation(line: 0, scope: !145, inlinedAt: !181)
!183 = !DILocation(line: 30, column: 27, scope: !168)
!184 = !DILocation(line: 30, column: 40, scope: !168)
!185 = !DILocation(line: 30, column: 49, scope: !168)
!186 = !DILocation(line: 30, column: 47, scope: !168)
!187 = !DILocation(line: 0, scope: !156, inlinedAt: !188)
!188 = distinct !DILocation(line: 30, column: 17, scope: !168)
!189 = !DILocation(line: 21, column: 22, scope: !156, inlinedAt: !188)
!190 = !DILocation(line: 22, column: 17, scope: !156, inlinedAt: !188)
!191 = !DILocation(line: 32, column: 22, scope: !168)
!192 = !DILocation(line: 32, column: 35, scope: !168)
!193 = !DILocation(line: 32, column: 45, scope: !168)
!194 = !DILocation(line: 32, column: 59, scope: !168)
!195 = !DILocation(line: 32, column: 68, scope: !168)
!196 = !DILocation(line: 32, column: 42, scope: !168)
!197 = !DILocation(line: 32, column: 66, scope: !168)
!198 = !DILocation(line: 0, scope: !156, inlinedAt: !199)
!199 = distinct !DILocation(line: 32, column: 12, scope: !168)
!200 = !DILocation(line: 21, column: 22, scope: !156, inlinedAt: !199)
!201 = !DILocation(line: 22, column: 17, scope: !156, inlinedAt: !199)
!202 = !DILocation(line: 32, column: 12, scope: !168)
!203 = !DILocation(line: 32, column: 5, scope: !168)
!204 = distinct !DISubprogram(name: "hash_cookie", scope: !146, file: !146, line: 37, type: !205, scopeLine: 37, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !207)
!205 = !DISubroutineType(types: !206)
!206 = !{!47, !47, !47}
!207 = !{!208, !209, !210}
!208 = !DILocalVariable(name: "hash", arg: 1, scope: !204, file: !146, line: 37, type: !47)
!209 = !DILocalVariable(name: "seqnum", arg: 2, scope: !204, file: !146, line: 37, type: !47)
!210 = !DILocalVariable(name: "hash_seed", scope: !204, file: !146, line: 38, type: !47)
!211 = !DILocation(line: 0, scope: !204)
!212 = !DILocation(line: 12, column: 18, scope: !145, inlinedAt: !213)
!213 = distinct !DILocation(line: 38, column: 23, scope: !204)
!214 = !DILocation(line: 0, scope: !145, inlinedAt: !213)
!215 = !DILocation(line: 40, column: 38, scope: !204)
!216 = !DILocation(line: 0, scope: !156, inlinedAt: !217)
!217 = distinct !DILocation(line: 40, column: 29, scope: !204)
!218 = !DILocation(line: 21, column: 22, scope: !156, inlinedAt: !217)
!219 = !DILocation(line: 22, column: 17, scope: !156, inlinedAt: !217)
!220 = !DILocation(line: 40, column: 12, scope: !204)
!221 = !DILocation(line: 40, column: 5, scope: !204)
!222 = distinct !DISubprogram(name: "write_hash_table", scope: !3, file: !3, line: 55, type: !223, scopeLine: 55, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !225)
!223 = !DISubroutineType(types: !224)
!224 = !{null, !47, !47}
!225 = !{!226, !227}
!226 = !DILocalVariable(name: "hash", arg: 1, scope: !222, file: !3, line: 55, type: !47)
!227 = !DILocalVariable(name: "key", arg: 2, scope: !222, file: !3, line: 55, type: !47)
!228 = !DILocation(line: 0, scope: !222)
!229 = !{!230, !230, i64 0}
!230 = !{!"int", !231, i64 0}
!231 = !{!"omnipotent char", !232, i64 0}
!232 = !{!"Simple C/C++ TBAA"}
!233 = !DILocation(line: 56, column: 42, scope: !222)
!234 = !DILocation(line: 56, column: 48, scope: !222)
!235 = !DILocation(line: 56, column: 5, scope: !222)
!236 = !DILocation(line: 58, column: 1, scope: !222)
!237 = distinct !DISubprogram(name: "write_white_table", scope: !3, file: !3, line: 62, type: !238, scopeLine: 62, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !242)
!238 = !DISubroutineType(types: !239)
!239 = !{null, !240, !47}
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "__s16", file: !45, line: 23, baseType: !241)
!241 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!242 = !{!243, !244}
!243 = !DILocalVariable(name: "reg", arg: 1, scope: !237, file: !3, line: 62, type: !240)
!244 = !DILocalVariable(name: "key", arg: 2, scope: !237, file: !3, line: 62, type: !47)
!245 = !DILocation(line: 0, scope: !237)
!246 = !{!247, !247, i64 0}
!247 = !{!"short", !231, i64 0}
!248 = !DILocation(line: 63, column: 43, scope: !237)
!249 = !DILocation(line: 63, column: 49, scope: !237)
!250 = !DILocation(line: 63, column: 5, scope: !237)
!251 = !DILocation(line: 65, column: 1, scope: !237)
!252 = distinct !DISubprogram(name: "stat_white", scope: !3, file: !3, line: 69, type: !253, scopeLine: 69, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !256)
!253 = !DISubroutineType(types: !254)
!254 = !{null, !255, !255, !255}
!255 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!256 = !{!257, !258, !259, !260, !261, !262, !263, !264, !272}
!257 = !DILocalVariable(name: "pass", arg: 1, scope: !252, file: !3, line: 69, type: !255)
!258 = !DILocalVariable(name: "drop", arg: 2, scope: !252, file: !3, line: 69, type: !255)
!259 = !DILocalVariable(name: "tx", arg: 3, scope: !252, file: !3, line: 69, type: !255)
!260 = !DILocalVariable(name: "key", scope: !252, file: !3, line: 70, type: !255)
!261 = !DILocalVariable(name: "kpass", scope: !252, file: !3, line: 71, type: !44)
!262 = !DILocalVariable(name: "kdrop", scope: !252, file: !3, line: 72, type: !44)
!263 = !DILocalVariable(name: "ktx", scope: !252, file: !3, line: 73, type: !44)
!264 = !DILocalVariable(name: "stat", scope: !252, file: !3, line: 74, type: !265)
!265 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !266, size: 64)
!266 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "StatData", file: !267, line: 6, size: 192, elements: !268)
!267 = !DIFile(filename: "./common_struct.h", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/XDP_syn_cookie")
!268 = !{!269, !270, !271}
!269 = !DIDerivedType(tag: DW_TAG_member, name: "KPass", scope: !266, file: !267, line: 7, baseType: !44, size: 64)
!270 = !DIDerivedType(tag: DW_TAG_member, name: "KDrop", scope: !266, file: !267, line: 8, baseType: !44, size: 64, offset: 64)
!271 = !DIDerivedType(tag: DW_TAG_member, name: "KTx", scope: !266, file: !267, line: 9, baseType: !44, size: 64, offset: 128)
!272 = !DILocalVariable(name: "new_stat", scope: !252, file: !3, line: 82, type: !266)
!273 = !DILocation(line: 0, scope: !252)
!274 = !DILocation(line: 70, column: 5, scope: !252)
!275 = !DILocation(line: 70, column: 9, scope: !252)
!276 = !DILocation(line: 74, column: 29, scope: !252)
!277 = !DILocation(line: 76, column: 8, scope: !278)
!278 = distinct !DILexicalBlock(scope: !252, file: !3, line: 76, column: 8)
!279 = !DILocation(line: 76, column: 8, scope: !252)
!280 = !DILocation(line: 77, column: 23, scope: !281)
!281 = distinct !DILexicalBlock(scope: !278, file: !3, line: 76, column: 13)
!282 = !{!283, !284, i64 0}
!283 = !{!"StatData", !284, i64 0, !284, i64 8, !284, i64 16}
!284 = !{!"long long", !231, i64 0}
!285 = !DILocation(line: 78, column: 23, scope: !281)
!286 = !{!283, !284, i64 8}
!287 = !DILocation(line: 79, column: 23, scope: !281)
!288 = !{!283, !284, i64 16}
!289 = !DILocation(line: 80, column: 5, scope: !281)
!290 = !DILocation(line: 82, column: 5, scope: !252)
!291 = !DILocation(line: 82, column: 21, scope: !252)
!292 = !DILocation(line: 84, column: 8, scope: !293)
!293 = distinct !DILexicalBlock(scope: !252, file: !3, line: 84, column: 8)
!294 = !DILocation(line: 84, column: 8, scope: !252)
!295 = !DILocation(line: 85, column: 32, scope: !296)
!296 = distinct !DILexicalBlock(scope: !293, file: !3, line: 84, column: 14)
!297 = !DILocation(line: 85, column: 18, scope: !296)
!298 = !DILocation(line: 85, column: 24, scope: !296)
!299 = !DILocation(line: 86, column: 18, scope: !296)
!300 = !DILocation(line: 86, column: 24, scope: !296)
!301 = !DILocation(line: 88, column: 5, scope: !296)
!302 = !DILocation(line: 89, column: 13, scope: !303)
!303 = distinct !DILexicalBlock(scope: !293, file: !3, line: 89, column: 13)
!304 = !DILocation(line: 89, column: 13, scope: !293)
!305 = !DILocation(line: 90, column: 18, scope: !306)
!306 = distinct !DILexicalBlock(scope: !303, file: !3, line: 89, column: 18)
!307 = !DILocation(line: 90, column: 24, scope: !306)
!308 = !DILocation(line: 91, column: 32, scope: !306)
!309 = !DILocation(line: 91, column: 18, scope: !306)
!310 = !DILocation(line: 91, column: 24, scope: !306)
!311 = !DILocation(line: 93, column: 5, scope: !306)
!312 = !DILocation(line: 94, column: 13, scope: !313)
!313 = distinct !DILexicalBlock(scope: !303, file: !3, line: 94, column: 13)
!314 = !DILocation(line: 0, scope: !313)
!315 = !DILocation(line: 94, column: 13, scope: !303)
!316 = !DILocation(line: 0, scope: !293)
!317 = !DILocation(line: 105, column: 5, scope: !252)
!318 = !DILocation(line: 108, column: 1, scope: !252)
!319 = distinct !DISubprogram(name: "xdp_main", scope: !3, file: !3, line: 113, type: !320, scopeLine: 113, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !330)
!320 = !DISubroutineType(types: !321)
!321 = !{!255, !322}
!322 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !323, size: 64)
!323 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !324)
!324 = !{!325, !326, !327, !328, !329}
!325 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !323, file: !6, line: 2857, baseType: !47, size: 32)
!326 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !323, file: !6, line: 2858, baseType: !47, size: 32, offset: 32)
!327 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !323, file: !6, line: 2859, baseType: !47, size: 32, offset: 64)
!328 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !323, file: !6, line: 2861, baseType: !47, size: 32, offset: 96)
!329 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !323, file: !6, line: 2862, baseType: !47, size: 32, offset: 128)
!330 = !{!331, !332, !339, !340, !341, !345, !350, !351, !352, !353, !357, !358, !359, !360, !361, !365, !368}
!331 = !DILocalVariable(name: "ctx", arg: 1, scope: !319, file: !3, line: 113, type: !322)
!332 = !DILocalVariable(name: "Npack", scope: !319, file: !3, line: 114, type: !333)
!333 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "NetPacket", file: !3, line: 19, size: 256, elements: !334)
!334 = !{!335, !336, !337, !338}
!335 = !DIDerivedType(tag: DW_TAG_member, name: "ctx", scope: !333, file: !3, line: 20, baseType: !322, size: 64)
!336 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4", scope: !333, file: !3, line: 21, baseType: !64, size: 64, offset: 64)
!337 = !DIDerivedType(tag: DW_TAG_member, name: "tcp", scope: !333, file: !3, line: 22, baseType: !82, size: 64, offset: 128)
!338 = !DIDerivedType(tag: DW_TAG_member, name: "eth", scope: !333, file: !3, line: 23, baseType: !48, size: 64, offset: 192)
!339 = !DILocalVariable(name: "ipv4", scope: !319, file: !3, line: 129, type: !64)
!340 = !DILocalVariable(name: "tcp", scope: !319, file: !3, line: 141, type: !82)
!341 = !DILocalVariable(name: "reg", scope: !342, file: !3, line: 150, type: !344)
!342 = distinct !DILexicalBlock(scope: !343, file: !3, line: 148, column: 84)
!343 = distinct !DILexicalBlock(scope: !319, file: !3, line: 148, column: 9)
!344 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !240, size: 64)
!345 = !DILocalVariable(name: "new_reg", scope: !346, file: !3, line: 160, type: !240)
!346 = distinct !DILexicalBlock(scope: !347, file: !3, line: 159, column: 32)
!347 = distinct !DILexicalBlock(scope: !348, file: !3, line: 159, column: 16)
!348 = distinct !DILexicalBlock(scope: !349, file: !3, line: 153, column: 31)
!349 = distinct !DILexicalBlock(scope: !342, file: !3, line: 153, column: 12)
!350 = !DILocalVariable(name: "temp_sport", scope: !346, file: !3, line: 171, type: !61)
!351 = !DILocalVariable(name: "temp_saddr", scope: !346, file: !3, line: 176, type: !47)
!352 = !DILocalVariable(name: "temp_eth", scope: !346, file: !3, line: 181, type: !49)
!353 = !DILocalVariable(name: "hash", scope: !354, file: !3, line: 199, type: !47)
!354 = distinct !DILexicalBlock(scope: !355, file: !3, line: 197, column: 32)
!355 = distinct !DILexicalBlock(scope: !356, file: !3, line: 197, column: 16)
!356 = distinct !DILexicalBlock(scope: !349, file: !3, line: 193, column: 14)
!357 = !DILocalVariable(name: "cookie", scope: !354, file: !3, line: 200, type: !47)
!358 = !DILocalVariable(name: "temp_sport", scope: !354, file: !3, line: 212, type: !61)
!359 = !DILocalVariable(name: "temp_saddr", scope: !354, file: !3, line: 217, type: !47)
!360 = !DILocalVariable(name: "temp_eth", scope: !354, file: !3, line: 222, type: !49)
!361 = !DILocalVariable(name: "cookie_table", scope: !362, file: !3, line: 231, type: !364)
!362 = distinct !DILexicalBlock(scope: !363, file: !3, line: 229, column: 37)
!363 = distinct !DILexicalBlock(scope: !355, file: !3, line: 229, column: 21)
!364 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!365 = !DILocalVariable(name: "cookie_client", scope: !366, file: !3, line: 240, type: !47)
!366 = distinct !DILexicalBlock(scope: !367, file: !3, line: 234, column: 34)
!367 = distinct !DILexicalBlock(scope: !362, file: !3, line: 234, column: 21)
!368 = !DILocalVariable(name: "reg", scope: !369, file: !3, line: 243, type: !240)
!369 = distinct !DILexicalBlock(scope: !370, file: !3, line: 242, column: 56)
!370 = distinct !DILexicalBlock(scope: !366, file: !3, line: 242, column: 25)
!371 = !DILocation(line: 82, column: 21, scope: !252, inlinedAt: !372)
!372 = distinct !DILocation(line: 260, column: 17, scope: !373)
!373 = distinct !DILexicalBlock(scope: !363, file: !3, line: 259, column: 18)
!374 = !DILocation(line: 82, column: 21, scope: !252, inlinedAt: !375)
!375 = distinct !DILocation(line: 256, column: 17, scope: !362)
!376 = !DILocation(line: 82, column: 21, scope: !252, inlinedAt: !377)
!377 = distinct !DILocation(line: 252, column: 21, scope: !366)
!378 = !DILocation(line: 82, column: 21, scope: !252, inlinedAt: !379)
!379 = distinct !DILocation(line: 248, column: 25, scope: !369)
!380 = !DILocation(line: 82, column: 21, scope: !252, inlinedAt: !381)
!381 = distinct !DILocation(line: 226, column: 17, scope: !354)
!382 = !DILocation(line: 82, column: 21, scope: !252, inlinedAt: !383)
!383 = distinct !DILocation(line: 189, column: 17, scope: !384)
!384 = distinct !DILexicalBlock(scope: !347, file: !3, line: 188, column: 17)
!385 = !DILocation(line: 82, column: 21, scope: !252, inlinedAt: !386)
!386 = distinct !DILocation(line: 185, column: 17, scope: !346)
!387 = !DILocation(line: 0, scope: !319)
!388 = !DILocation(line: 116, column: 45, scope: !319)
!389 = !{!390, !230, i64 0}
!390 = !{!"xdp_md", !230, i64 0, !230, i64 4, !230, i64 8, !230, i64 12, !230, i64 16}
!391 = !DILocation(line: 116, column: 33, scope: !319)
!392 = !DILocation(line: 116, column: 17, scope: !319)
!393 = !DILocation(line: 119, column: 8, scope: !394)
!394 = distinct !DILexicalBlock(scope: !319, file: !3, line: 119, column: 8)
!395 = !DILocation(line: 119, column: 45, scope: !394)
!396 = !{!390, !230, i64 4}
!397 = !DILocation(line: 119, column: 33, scope: !394)
!398 = !DILocation(line: 119, column: 31, scope: !394)
!399 = !DILocation(line: 119, column: 8, scope: !319)
!400 = !DILocation(line: 124, column: 19, scope: !401)
!401 = distinct !DILexicalBlock(scope: !319, file: !3, line: 124, column: 8)
!402 = !{!403, !247, i64 12}
!403 = !{!"ethhdr", !231, i64 0, !231, i64 6, !247, i64 12}
!404 = !DILocation(line: 124, column: 27, scope: !401)
!405 = !DILocation(line: 124, column: 8, scope: !319)
!406 = !DILocation(line: 130, column: 21, scope: !407)
!407 = distinct !DILexicalBlock(scope: !319, file: !3, line: 130, column: 8)
!408 = !DILocation(line: 130, column: 8, scope: !407)
!409 = !DILocation(line: 130, column: 26, scope: !407)
!410 = !DILocation(line: 130, column: 8, scope: !319)
!411 = !DILocation(line: 136, column: 20, scope: !412)
!412 = distinct !DILexicalBlock(scope: !319, file: !3, line: 136, column: 8)
!413 = !{!414, !231, i64 9}
!414 = !{!"iphdr", !231, i64 0, !231, i64 0, !231, i64 1, !247, i64 2, !247, i64 4, !247, i64 6, !231, i64 8, !231, i64 9, !247, i64 10, !230, i64 12, !230, i64 16}
!415 = !DILocation(line: 136, column: 29, scope: !412)
!416 = !DILocation(line: 136, column: 8, scope: !319)
!417 = !DILocation(line: 142, column: 20, scope: !418)
!418 = distinct !DILexicalBlock(scope: !319, file: !3, line: 142, column: 8)
!419 = !DILocation(line: 142, column: 25, scope: !418)
!420 = !DILocation(line: 142, column: 8, scope: !319)
!421 = !DILocation(line: 148, column: 10, scope: !343)
!422 = !{!423, !247, i64 2}
!423 = !{!"tcphdr", !247, i64 0, !247, i64 2, !230, i64 4, !230, i64 8, !247, i64 12, !247, i64 12, !247, i64 13, !247, i64 13, !247, i64 13, !247, i64 13, !247, i64 13, !247, i64 13, !247, i64 13, !247, i64 13, !247, i64 14, !247, i64 16, !247, i64 18}
!424 = !DILocation(line: 148, column: 44, scope: !343)
!425 = !DILocation(line: 150, column: 73, scope: !342)
!426 = !DILocation(line: 150, column: 60, scope: !342)
!427 = !DILocation(line: 150, column: 22, scope: !342)
!428 = !DILocation(line: 0, scope: !342)
!429 = !DILocation(line: 153, column: 12, scope: !349)
!430 = !DILocation(line: 153, column: 16, scope: !349)
!431 = !DILocation(line: 153, column: 20, scope: !349)
!432 = !DILocation(line: 153, column: 25, scope: !349)
!433 = !DILocation(line: 153, column: 12, scope: !342)
!434 = !DILocation(line: 159, column: 27, scope: !347)
!435 = !DILocation(line: 159, column: 16, scope: !347)
!436 = !DILocation(line: 159, column: 16, scope: !348)
!437 = !DILocation(line: 160, column: 38, scope: !346)
!438 = !DILocation(line: 0, scope: !346)
!439 = !DILocation(line: 163, column: 56, scope: !346)
!440 = !{!414, !230, i64 12}
!441 = !DILocation(line: 0, scope: !237, inlinedAt: !442)
!442 = distinct !DILocation(line: 163, column: 17, scope: !346)
!443 = !DILocation(line: 63, column: 5, scope: !237, inlinedAt: !442)
!444 = !DILocation(line: 65, column: 1, scope: !237, inlinedAt: !442)
!445 = !DILocation(line: 166, column: 38, scope: !346)
!446 = !{!423, !230, i64 4}
!447 = !DILocation(line: 166, column: 28, scope: !346)
!448 = !DILocation(line: 166, column: 36, scope: !346)
!449 = !{!423, !230, i64 8}
!450 = !DILocation(line: 167, column: 32, scope: !346)
!451 = !DILocation(line: 168, column: 32, scope: !346)
!452 = !DILocation(line: 171, column: 47, scope: !346)
!453 = !{!423, !247, i64 0}
!454 = !DILocation(line: 172, column: 48, scope: !346)
!455 = !DILocation(line: 172, column: 35, scope: !346)
!456 = !DILocation(line: 173, column: 33, scope: !346)
!457 = !DILocation(line: 176, column: 48, scope: !346)
!458 = !DILocation(line: 177, column: 49, scope: !346)
!459 = !{!414, !230, i64 16}
!460 = !DILocation(line: 177, column: 35, scope: !346)
!461 = !DILocation(line: 178, column: 35, scope: !346)
!462 = !DILocation(line: 181, column: 17, scope: !346)
!463 = !DILocation(line: 181, column: 31, scope: !346)
!464 = !DILocation(line: 181, column: 42, scope: !346)
!465 = !{i64 0, i64 6, !466, i64 6, i64 6, !466, i64 12, i64 2, !246}
!466 = !{!231, !231, i64 0}
!467 = !DILocation(line: 182, column: 17, scope: !346)
!468 = !DILocation(line: 183, column: 17, scope: !346)
!469 = !DILocation(line: 0, scope: !252, inlinedAt: !386)
!470 = !DILocation(line: 70, column: 5, scope: !252, inlinedAt: !386)
!471 = !DILocation(line: 70, column: 9, scope: !252, inlinedAt: !386)
!472 = !DILocation(line: 74, column: 29, scope: !252, inlinedAt: !386)
!473 = !DILocation(line: 76, column: 8, scope: !278, inlinedAt: !386)
!474 = !DILocation(line: 76, column: 8, scope: !252, inlinedAt: !386)
!475 = !DILocation(line: 77, column: 23, scope: !281, inlinedAt: !386)
!476 = !DILocation(line: 78, column: 23, scope: !281, inlinedAt: !386)
!477 = !DILocation(line: 79, column: 23, scope: !281, inlinedAt: !386)
!478 = !DILocation(line: 80, column: 5, scope: !281, inlinedAt: !386)
!479 = !DILocation(line: 82, column: 5, scope: !252, inlinedAt: !386)
!480 = !DILocation(line: 0, scope: !313, inlinedAt: !386)
!481 = !DILocation(line: 97, column: 18, scope: !482, inlinedAt: !386)
!482 = distinct !DILexicalBlock(scope: !313, file: !3, line: 94, column: 16)
!483 = !DILocation(line: 97, column: 24, scope: !482, inlinedAt: !386)
!484 = !DILocation(line: 105, column: 5, scope: !252, inlinedAt: !386)
!485 = !DILocation(line: 108, column: 1, scope: !252, inlinedAt: !386)
!486 = !DILocation(line: 187, column: 13, scope: !347)
!487 = !DILocation(line: 0, scope: !252, inlinedAt: !383)
!488 = !DILocation(line: 70, column: 5, scope: !252, inlinedAt: !383)
!489 = !DILocation(line: 70, column: 9, scope: !252, inlinedAt: !383)
!490 = !DILocation(line: 74, column: 29, scope: !252, inlinedAt: !383)
!491 = !DILocation(line: 76, column: 8, scope: !278, inlinedAt: !383)
!492 = !DILocation(line: 76, column: 8, scope: !252, inlinedAt: !383)
!493 = !DILocation(line: 77, column: 23, scope: !281, inlinedAt: !383)
!494 = !DILocation(line: 78, column: 23, scope: !281, inlinedAt: !383)
!495 = !DILocation(line: 79, column: 23, scope: !281, inlinedAt: !383)
!496 = !DILocation(line: 80, column: 5, scope: !281, inlinedAt: !383)
!497 = !DILocation(line: 82, column: 5, scope: !252, inlinedAt: !383)
!498 = !DILocation(line: 85, column: 18, scope: !296, inlinedAt: !383)
!499 = !DILocation(line: 85, column: 24, scope: !296, inlinedAt: !383)
!500 = !DILocation(line: 86, column: 18, scope: !296, inlinedAt: !383)
!501 = !DILocation(line: 86, column: 24, scope: !296, inlinedAt: !383)
!502 = !DILocation(line: 87, column: 18, scope: !296, inlinedAt: !383)
!503 = !DILocation(line: 87, column: 24, scope: !296, inlinedAt: !383)
!504 = !DILocation(line: 105, column: 5, scope: !252, inlinedAt: !383)
!505 = !DILocation(line: 108, column: 1, scope: !252, inlinedAt: !383)
!506 = !DILocation(line: 190, column: 17, scope: !384)
!507 = !DILocation(line: 197, column: 27, scope: !355)
!508 = !DILocation(line: 197, column: 16, scope: !355)
!509 = !DILocation(line: 197, column: 16, scope: !356)
!510 = !DILocation(line: 199, column: 54, scope: !354)
!511 = !DILocation(line: 199, column: 73, scope: !354)
!512 = !DILocation(line: 199, column: 91, scope: !354)
!513 = !DILocation(line: 199, column: 110, scope: !354)
!514 = !DILocation(line: 199, column: 116, scope: !354)
!515 = !DILocation(line: 199, column: 142, scope: !354)
!516 = !DILocation(line: 0, scope: !168, inlinedAt: !517)
!517 = distinct !DILocation(line: 199, column: 30, scope: !354)
!518 = !DILocation(line: 12, column: 18, scope: !145, inlinedAt: !519)
!519 = distinct !DILocation(line: 28, column: 25, scope: !168, inlinedAt: !517)
!520 = !DILocation(line: 0, scope: !145, inlinedAt: !519)
!521 = !DILocation(line: 30, column: 27, scope: !168, inlinedAt: !517)
!522 = !DILocation(line: 30, column: 40, scope: !168, inlinedAt: !517)
!523 = !DILocation(line: 30, column: 49, scope: !168, inlinedAt: !517)
!524 = !DILocation(line: 30, column: 47, scope: !168, inlinedAt: !517)
!525 = !DILocation(line: 0, scope: !156, inlinedAt: !526)
!526 = distinct !DILocation(line: 30, column: 17, scope: !168, inlinedAt: !517)
!527 = !DILocation(line: 21, column: 22, scope: !156, inlinedAt: !526)
!528 = !DILocation(line: 22, column: 17, scope: !156, inlinedAt: !526)
!529 = !DILocation(line: 32, column: 22, scope: !168, inlinedAt: !517)
!530 = !DILocation(line: 32, column: 35, scope: !168, inlinedAt: !517)
!531 = !DILocation(line: 32, column: 45, scope: !168, inlinedAt: !517)
!532 = !DILocation(line: 32, column: 59, scope: !168, inlinedAt: !517)
!533 = !DILocation(line: 32, column: 68, scope: !168, inlinedAt: !517)
!534 = !DILocation(line: 32, column: 42, scope: !168, inlinedAt: !517)
!535 = !DILocation(line: 32, column: 66, scope: !168, inlinedAt: !517)
!536 = !DILocation(line: 0, scope: !156, inlinedAt: !537)
!537 = distinct !DILocation(line: 32, column: 12, scope: !168, inlinedAt: !517)
!538 = !DILocation(line: 21, column: 22, scope: !156, inlinedAt: !537)
!539 = !DILocation(line: 22, column: 17, scope: !156, inlinedAt: !537)
!540 = !DILocation(line: 0, scope: !354)
!541 = !DILocation(line: 200, column: 50, scope: !354)
!542 = !DILocation(line: 200, column: 76, scope: !354)
!543 = !DILocation(line: 0, scope: !204, inlinedAt: !544)
!544 = distinct !DILocation(line: 200, column: 32, scope: !354)
!545 = !DILocation(line: 12, column: 18, scope: !145, inlinedAt: !546)
!546 = distinct !DILocation(line: 38, column: 23, scope: !204, inlinedAt: !544)
!547 = !DILocation(line: 0, scope: !145, inlinedAt: !546)
!548 = !DILocation(line: 40, column: 38, scope: !204, inlinedAt: !544)
!549 = !DILocation(line: 0, scope: !156, inlinedAt: !550)
!550 = distinct !DILocation(line: 40, column: 29, scope: !204, inlinedAt: !544)
!551 = !DILocation(line: 21, column: 22, scope: !156, inlinedAt: !550)
!552 = !DILocation(line: 22, column: 17, scope: !156, inlinedAt: !550)
!553 = !DILocation(line: 40, column: 12, scope: !204, inlinedAt: !544)
!554 = !DILocation(line: 204, column: 54, scope: !354)
!555 = !DILocation(line: 0, scope: !222, inlinedAt: !556)
!556 = distinct !DILocation(line: 204, column: 17, scope: !354)
!557 = !DILocation(line: 56, column: 5, scope: !222, inlinedAt: !556)
!558 = !DILocation(line: 58, column: 1, scope: !222, inlinedAt: !556)
!559 = !DILocation(line: 207, column: 38, scope: !354)
!560 = !DILocation(line: 207, column: 28, scope: !354)
!561 = !DILocation(line: 207, column: 36, scope: !354)
!562 = !DILocation(line: 208, column: 34, scope: !354)
!563 = !DILocation(line: 208, column: 32, scope: !354)
!564 = !DILocation(line: 209, column: 32, scope: !354)
!565 = !DILocation(line: 212, column: 47, scope: !354)
!566 = !DILocation(line: 213, column: 48, scope: !354)
!567 = !DILocation(line: 213, column: 35, scope: !354)
!568 = !DILocation(line: 214, column: 33, scope: !354)
!569 = !DILocation(line: 217, column: 48, scope: !354)
!570 = !DILocation(line: 218, column: 49, scope: !354)
!571 = !DILocation(line: 218, column: 35, scope: !354)
!572 = !DILocation(line: 219, column: 35, scope: !354)
!573 = !DILocation(line: 222, column: 17, scope: !354)
!574 = !DILocation(line: 222, column: 31, scope: !354)
!575 = !DILocation(line: 222, column: 42, scope: !354)
!576 = !DILocation(line: 223, column: 17, scope: !354)
!577 = !DILocation(line: 224, column: 17, scope: !354)
!578 = !DILocation(line: 0, scope: !252, inlinedAt: !381)
!579 = !DILocation(line: 70, column: 5, scope: !252, inlinedAt: !381)
!580 = !DILocation(line: 70, column: 9, scope: !252, inlinedAt: !381)
!581 = !DILocation(line: 74, column: 29, scope: !252, inlinedAt: !381)
!582 = !DILocation(line: 76, column: 8, scope: !278, inlinedAt: !381)
!583 = !DILocation(line: 76, column: 8, scope: !252, inlinedAt: !381)
!584 = !DILocation(line: 77, column: 23, scope: !281, inlinedAt: !381)
!585 = !DILocation(line: 78, column: 23, scope: !281, inlinedAt: !381)
!586 = !DILocation(line: 79, column: 23, scope: !281, inlinedAt: !381)
!587 = !DILocation(line: 80, column: 5, scope: !281, inlinedAt: !381)
!588 = !DILocation(line: 82, column: 5, scope: !252, inlinedAt: !381)
!589 = !DILocation(line: 0, scope: !313, inlinedAt: !381)
!590 = !DILocation(line: 97, column: 18, scope: !482, inlinedAt: !381)
!591 = !DILocation(line: 97, column: 24, scope: !482, inlinedAt: !381)
!592 = !DILocation(line: 105, column: 5, scope: !252, inlinedAt: !381)
!593 = !DILocation(line: 108, column: 1, scope: !252, inlinedAt: !381)
!594 = !DILocation(line: 228, column: 13, scope: !355)
!595 = !DILocation(line: 229, column: 32, scope: !363)
!596 = !DILocation(line: 229, column: 21, scope: !363)
!597 = !DILocation(line: 229, column: 21, scope: !355)
!598 = !DILocation(line: 231, column: 39, scope: !362)
!599 = !DILocation(line: 0, scope: !362)
!600 = !DILocation(line: 234, column: 21, scope: !367)
!601 = !DILocation(line: 234, column: 21, scope: !362)
!602 = !DILocation(line: 240, column: 43, scope: !366)
!603 = !DILocation(line: 240, column: 73, scope: !366)
!604 = !DILocation(line: 0, scope: !366)
!605 = !DILocation(line: 242, column: 42, scope: !370)
!606 = !DILocation(line: 242, column: 39, scope: !370)
!607 = !DILocation(line: 242, column: 25, scope: !366)
!608 = !DILocation(line: 0, scope: !369)
!609 = !DILocation(line: 246, column: 60, scope: !369)
!610 = !DILocation(line: 0, scope: !237, inlinedAt: !611)
!611 = distinct !DILocation(line: 246, column: 25, scope: !369)
!612 = !DILocation(line: 63, column: 5, scope: !237, inlinedAt: !611)
!613 = !DILocation(line: 65, column: 1, scope: !237, inlinedAt: !611)
!614 = !DILocation(line: 0, scope: !252, inlinedAt: !379)
!615 = !DILocation(line: 70, column: 5, scope: !252, inlinedAt: !379)
!616 = !DILocation(line: 70, column: 9, scope: !252, inlinedAt: !379)
!617 = !DILocation(line: 74, column: 29, scope: !252, inlinedAt: !379)
!618 = !DILocation(line: 76, column: 8, scope: !278, inlinedAt: !379)
!619 = !DILocation(line: 76, column: 8, scope: !252, inlinedAt: !379)
!620 = !DILocation(line: 77, column: 23, scope: !281, inlinedAt: !379)
!621 = !DILocation(line: 78, column: 23, scope: !281, inlinedAt: !379)
!622 = !DILocation(line: 79, column: 23, scope: !281, inlinedAt: !379)
!623 = !DILocation(line: 80, column: 5, scope: !281, inlinedAt: !379)
!624 = !DILocation(line: 82, column: 5, scope: !252, inlinedAt: !379)
!625 = !DILocation(line: 85, column: 18, scope: !296, inlinedAt: !379)
!626 = !DILocation(line: 85, column: 24, scope: !296, inlinedAt: !379)
!627 = !DILocation(line: 86, column: 18, scope: !296, inlinedAt: !379)
!628 = !DILocation(line: 86, column: 24, scope: !296, inlinedAt: !379)
!629 = !DILocation(line: 87, column: 18, scope: !296, inlinedAt: !379)
!630 = !DILocation(line: 87, column: 24, scope: !296, inlinedAt: !379)
!631 = !DILocation(line: 105, column: 5, scope: !252, inlinedAt: !379)
!632 = !DILocation(line: 108, column: 1, scope: !252, inlinedAt: !379)
!633 = !DILocation(line: 0, scope: !252, inlinedAt: !377)
!634 = !DILocation(line: 70, column: 5, scope: !252, inlinedAt: !377)
!635 = !DILocation(line: 70, column: 9, scope: !252, inlinedAt: !377)
!636 = !DILocation(line: 74, column: 29, scope: !252, inlinedAt: !377)
!637 = !DILocation(line: 76, column: 8, scope: !278, inlinedAt: !377)
!638 = !DILocation(line: 76, column: 8, scope: !252, inlinedAt: !377)
!639 = !DILocation(line: 77, column: 23, scope: !281, inlinedAt: !377)
!640 = !DILocation(line: 78, column: 23, scope: !281, inlinedAt: !377)
!641 = !DILocation(line: 79, column: 23, scope: !281, inlinedAt: !377)
!642 = !DILocation(line: 80, column: 5, scope: !281, inlinedAt: !377)
!643 = !DILocation(line: 82, column: 5, scope: !252, inlinedAt: !377)
!644 = !DILocation(line: 90, column: 18, scope: !306, inlinedAt: !377)
!645 = !DILocation(line: 90, column: 24, scope: !306, inlinedAt: !377)
!646 = !DILocation(line: 91, column: 18, scope: !306, inlinedAt: !377)
!647 = !DILocation(line: 91, column: 24, scope: !306, inlinedAt: !377)
!648 = !DILocation(line: 92, column: 18, scope: !306, inlinedAt: !377)
!649 = !DILocation(line: 92, column: 24, scope: !306, inlinedAt: !377)
!650 = !DILocation(line: 105, column: 5, scope: !252, inlinedAt: !377)
!651 = !DILocation(line: 108, column: 1, scope: !252, inlinedAt: !377)
!652 = !DILocation(line: 253, column: 21, scope: !366)
!653 = !DILocation(line: 0, scope: !252, inlinedAt: !375)
!654 = !DILocation(line: 70, column: 5, scope: !252, inlinedAt: !375)
!655 = !DILocation(line: 70, column: 9, scope: !252, inlinedAt: !375)
!656 = !DILocation(line: 74, column: 29, scope: !252, inlinedAt: !375)
!657 = !DILocation(line: 76, column: 8, scope: !278, inlinedAt: !375)
!658 = !DILocation(line: 76, column: 8, scope: !252, inlinedAt: !375)
!659 = !DILocation(line: 77, column: 23, scope: !281, inlinedAt: !375)
!660 = !DILocation(line: 78, column: 23, scope: !281, inlinedAt: !375)
!661 = !DILocation(line: 79, column: 23, scope: !281, inlinedAt: !375)
!662 = !DILocation(line: 80, column: 5, scope: !281, inlinedAt: !375)
!663 = !DILocation(line: 82, column: 5, scope: !252, inlinedAt: !375)
!664 = !DILocation(line: 90, column: 18, scope: !306, inlinedAt: !375)
!665 = !DILocation(line: 90, column: 24, scope: !306, inlinedAt: !375)
!666 = !DILocation(line: 91, column: 18, scope: !306, inlinedAt: !375)
!667 = !DILocation(line: 91, column: 24, scope: !306, inlinedAt: !375)
!668 = !DILocation(line: 92, column: 18, scope: !306, inlinedAt: !375)
!669 = !DILocation(line: 92, column: 24, scope: !306, inlinedAt: !375)
!670 = !DILocation(line: 105, column: 5, scope: !252, inlinedAt: !375)
!671 = !DILocation(line: 108, column: 1, scope: !252, inlinedAt: !375)
!672 = !DILocation(line: 257, column: 17, scope: !362)
!673 = !DILocation(line: 0, scope: !252, inlinedAt: !372)
!674 = !DILocation(line: 70, column: 5, scope: !252, inlinedAt: !372)
!675 = !DILocation(line: 70, column: 9, scope: !252, inlinedAt: !372)
!676 = !DILocation(line: 74, column: 29, scope: !252, inlinedAt: !372)
!677 = !DILocation(line: 76, column: 8, scope: !278, inlinedAt: !372)
!678 = !DILocation(line: 76, column: 8, scope: !252, inlinedAt: !372)
!679 = !DILocation(line: 77, column: 23, scope: !281, inlinedAt: !372)
!680 = !DILocation(line: 78, column: 23, scope: !281, inlinedAt: !372)
!681 = !DILocation(line: 79, column: 23, scope: !281, inlinedAt: !372)
!682 = !DILocation(line: 80, column: 5, scope: !281, inlinedAt: !372)
!683 = !DILocation(line: 82, column: 5, scope: !252, inlinedAt: !372)
!684 = !DILocation(line: 85, column: 18, scope: !296, inlinedAt: !372)
!685 = !DILocation(line: 85, column: 24, scope: !296, inlinedAt: !372)
!686 = !DILocation(line: 86, column: 18, scope: !296, inlinedAt: !372)
!687 = !DILocation(line: 86, column: 24, scope: !296, inlinedAt: !372)
!688 = !DILocation(line: 87, column: 18, scope: !296, inlinedAt: !372)
!689 = !DILocation(line: 87, column: 24, scope: !296, inlinedAt: !372)
!690 = !DILocation(line: 105, column: 5, scope: !252, inlinedAt: !372)
!691 = !DILocation(line: 108, column: 1, scope: !252, inlinedAt: !372)
!692 = !DILocation(line: 261, column: 17, scope: !373)
!693 = !DILocation(line: 267, column: 1, scope: !319)
