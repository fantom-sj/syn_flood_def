; ModuleID = 'xdp_kern.c'
source_filename = "xdp_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.HashTable = type { i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@data_cookis_map = dso_local global %struct.bpf_map_def { i32 1, i32 4, i32 24, i32 1024, i32 0 }, section "maps", align 4, !dbg !0
@hash_table_map = dso_local global %struct.bpf_map_def { i32 1, i32 4, i32 8, i32 1024, i32 0 }, section "maps", align 4, !dbg !104
@write_hash_table.____fmt = internal constant [34 x i8] c"Uspeshno dobavili %x\0A     key: %d\00", align 1, !dbg !114
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !133
@llvm.used = appending global [4 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.bpf_map_def* @data_cookis_map to i8*), i8* bitcast (%struct.bpf_map_def* @hash_table_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_main to i8*)], section "llvm.metadata"

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @hash_32(i32 %0, i16 zeroext %1) local_unnamed_addr #0 !dbg !162 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !168, metadata !DIExpression()), !dbg !171
  call void @llvm.dbg.value(metadata i16 %1, metadata !169, metadata !DIExpression()), !dbg !171
  %3 = mul i32 %0, 1640531527, !dbg !172
  call void @llvm.dbg.value(metadata i32 %3, metadata !170, metadata !DIExpression()), !dbg !171
  %4 = zext i16 %1 to i32, !dbg !173
  %5 = sub nsw i32 32, %4, !dbg !174
  %6 = lshr i32 %3, %5, !dbg !175
  ret i32 %6, !dbg !176
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @hash_tcp_ip(i32 %0, i32 %1, i16 zeroext %2, i16 zeroext %3, i32 %4) local_unnamed_addr #0 !dbg !177 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !181, metadata !DIExpression()), !dbg !188
  call void @llvm.dbg.value(metadata i32 %1, metadata !182, metadata !DIExpression()), !dbg !188
  call void @llvm.dbg.value(metadata i16 %2, metadata !183, metadata !DIExpression()), !dbg !188
  call void @llvm.dbg.value(metadata i16 %3, metadata !184, metadata !DIExpression()), !dbg !188
  call void @llvm.dbg.value(metadata i32 %4, metadata !185, metadata !DIExpression()), !dbg !188
  call void @llvm.dbg.value(metadata i32 -49120626, metadata !186, metadata !DIExpression()), !dbg !188
  call void @llvm.dbg.value(metadata i32 undef, metadata !187, metadata !DIExpression()), !dbg !188
  ret i32 undef, !dbg !189
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @hash_cookie(i32 %0, i32 %1, i32 %2) local_unnamed_addr #0 !dbg !190 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !194, metadata !DIExpression()), !dbg !197
  call void @llvm.dbg.value(metadata i32 %1, metadata !195, metadata !DIExpression()), !dbg !197
  call void @llvm.dbg.value(metadata i32 %2, metadata !196, metadata !DIExpression()), !dbg !197
  call void @llvm.dbg.value(metadata i32 %0, metadata !168, metadata !DIExpression()), !dbg !198
  call void @llvm.dbg.value(metadata i32 %2, metadata !169, metadata !DIExpression()), !dbg !198
  %4 = mul i32 %0, 1640531527, !dbg !200
  call void @llvm.dbg.value(metadata i32 %4, metadata !170, metadata !DIExpression()), !dbg !198
  %5 = and i32 %2, 65535, !dbg !201
  %6 = sub nsw i32 32, %5, !dbg !202
  %7 = lshr i32 %4, %6, !dbg !203
  %8 = add i32 %7, %1, !dbg !204
  ret i32 %8, !dbg !205
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @verify_cookies(i32 %0, i32 %1, i32 %2, i32 %3) local_unnamed_addr #0 !dbg !206 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !211, metadata !DIExpression()), !dbg !215
  call void @llvm.dbg.value(metadata i32 %1, metadata !212, metadata !DIExpression()), !dbg !215
  call void @llvm.dbg.value(metadata i32 %2, metadata !213, metadata !DIExpression()), !dbg !215
  call void @llvm.dbg.value(metadata i32 %3, metadata !214, metadata !DIExpression()), !dbg !215
  %5 = sub i32 %2, %1, !dbg !216
  call void @llvm.dbg.value(metadata i32 %5, metadata !213, metadata !DIExpression()), !dbg !215
  call void @llvm.dbg.value(metadata i32 %0, metadata !168, metadata !DIExpression()), !dbg !217
  call void @llvm.dbg.value(metadata i32 %3, metadata !169, metadata !DIExpression()), !dbg !217
  %6 = mul i32 %0, 1640531527, !dbg !219
  call void @llvm.dbg.value(metadata i32 %6, metadata !170, metadata !DIExpression()), !dbg !217
  %7 = and i32 %3, 65535, !dbg !220
  %8 = sub nsw i32 32, %7, !dbg !221
  %9 = lshr i32 %6, %8, !dbg !222
  %10 = icmp eq i32 %5, %9, !dbg !223
  %11 = zext i1 %10 to i32, !dbg !223
  ret i32 %11, !dbg !224
}

; Function Attrs: nounwind
define dso_local i32 @cookie_counter() local_unnamed_addr #3 !dbg !225 {
  %1 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !229
  %2 = lshr i64 %1, 33, !dbg !230
  %3 = trunc i64 %2 to i32, !dbg !229
  ret i32 %3, !dbg !231
}

; Function Attrs: nounwind
define dso_local void @write_hash_table(%struct.HashTable* %0) local_unnamed_addr #3 !dbg !116 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.HashTable* %0, metadata !126, metadata !DIExpression()), !dbg !232
  %3 = bitcast i32* %2 to i8*, !dbg !233
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #4, !dbg !233
  %4 = getelementptr inbounds %struct.HashTable, %struct.HashTable* %0, i64 0, i32 0, !dbg !234
  %5 = load i32, i32* %4, align 4, !dbg !234, !tbaa !235
  call void @llvm.dbg.value(metadata i32 %5, metadata !127, metadata !DIExpression()), !dbg !232
  store i32 %5, i32* %2, align 4, !dbg !240, !tbaa !241
  %6 = bitcast %struct.HashTable* %0 to i8*, !dbg !242
  call void @llvm.dbg.value(metadata i32* %2, metadata !127, metadata !DIExpression(DW_OP_deref)), !dbg !232
  %7 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @hash_table_map to i8*), i8* nonnull %3, i8* %6, i64 0) #4, !dbg !243
  %8 = getelementptr inbounds %struct.HashTable, %struct.HashTable* %0, i64 0, i32 1, !dbg !244
  %9 = load i32, i32* %8, align 4, !dbg !244, !tbaa !246
  %10 = load i32, i32* %2, align 4, !dbg !244, !tbaa !241
  call void @llvm.dbg.value(metadata i32 %10, metadata !127, metadata !DIExpression()), !dbg !232
  %11 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @write_hash_table.____fmt, i64 0, i64 0), i32 34, i32 %9, i32 %10) #4, !dbg !244
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #4, !dbg !247
  ret void, !dbg !247
}

; Function Attrs: nounwind
define dso_local i32 @xdp_main(%struct.xdp_md* nocapture readonly %0) #3 section "prog" !dbg !248 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.HashTable, align 4
  %4 = alloca %struct.ethhdr, align 1
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !260, metadata !DIExpression()), !dbg !281
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !261, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !281
  %5 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !282
  %6 = load i32, i32* %5, align 4, !dbg !282, !tbaa !283
  %7 = zext i32 %6 to i64, !dbg !285
  %8 = inttoptr i64 %7 to i8*, !dbg !285
  %9 = inttoptr i64 %7 to %struct.ethhdr*, !dbg !286
  call void @llvm.dbg.value(metadata %struct.ethhdr* %9, metadata !261, metadata !DIExpression(DW_OP_LLVM_fragment, 192, 64)), !dbg !281
  %10 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 1, i32 0, i64 0, !dbg !287
  %11 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !289
  %12 = load i32, i32* %11, align 4, !dbg !289, !tbaa !290
  %13 = zext i32 %12 to i64, !dbg !291
  %14 = inttoptr i64 %13 to i8*, !dbg !291
  %15 = icmp ugt i8* %10, %14, !dbg !292
  br i1 %15, label %84, label %16, !dbg !293

16:                                               ; preds = %1
  %17 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 0, i32 2, !dbg !294
  %18 = load i16, i16* %17, align 1, !dbg !294, !tbaa !296
  %19 = icmp eq i16 %18, 8, !dbg !299
  br i1 %19, label %20, label %84, !dbg !300

20:                                               ; preds = %16
  call void @llvm.dbg.value(metadata %struct.ethhdr* %9, metadata !268, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !281
  %21 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 2, i32 1, !dbg !301
  %22 = getelementptr [6 x i8], [6 x i8]* %21, i64 0, i64 0, !dbg !303
  %23 = icmp ugt i8* %22, %14, !dbg !304
  br i1 %23, label %84, label %24, !dbg !305

24:                                               ; preds = %20
  call void @llvm.dbg.value(metadata %struct.ethhdr* %9, metadata !261, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value, DW_OP_LLVM_fragment, 64, 64)), !dbg !281
  %25 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 1, i32 1, i64 3, !dbg !306
  %26 = load i8, i8* %25, align 1, !dbg !306, !tbaa !308
  %27 = icmp eq i8 %26, 6, !dbg !310
  br i1 %27, label %28, label %84, !dbg !311

28:                                               ; preds = %24
  call void @llvm.dbg.value(metadata [6 x i8]* %21, metadata !269, metadata !DIExpression()), !dbg !281
  %29 = getelementptr inbounds [6 x i8], [6 x i8]* %21, i64 3, i64 2, !dbg !312
  %30 = icmp ugt i8* %29, %14, !dbg !314
  br i1 %30, label %84, label %31, !dbg !315

31:                                               ; preds = %28
  call void @llvm.dbg.value(metadata [6 x i8]* %21, metadata !261, metadata !DIExpression(DW_OP_LLVM_fragment, 128, 64)), !dbg !281
  %32 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 2, i32 1, i64 2, !dbg !316
  %33 = bitcast i8* %32 to i16*, !dbg !316
  %34 = load i16, i16* %33, align 2, !dbg !316, !tbaa !317
  %35 = tail call i16 @llvm.bswap.i16(i16 %34)
  switch i16 %35, label %84 [
    i16 80, label %36
    i16 443, label %36
  ], !dbg !319

36:                                               ; preds = %31, %31
  %37 = getelementptr inbounds [6 x i8], [6 x i8]* %21, i64 2, !dbg !320
  %38 = bitcast [6 x i8]* %37 to i16*, !dbg !320
  %39 = load i16, i16* %38, align 4, !dbg !320
  %40 = and i16 %39, 512, !dbg !320
  %41 = icmp eq i16 %40, 0, !dbg !321
  br i1 %41, label %84, label %42, !dbg !322

42:                                               ; preds = %36
  %43 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 1, i32 2, !dbg !323
  %44 = bitcast i16* %43 to i32*, !dbg !323
  %45 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 2, i32 0, i64 2, !dbg !324
  %46 = bitcast i8* %45 to i32*, !dbg !324
  %47 = bitcast [6 x i8]* %21 to i16*, !dbg !325
  %48 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 2, i32 1, i64 4, !dbg !326
  %49 = bitcast i8* %48 to i32*, !dbg !326
  %50 = load i32, i32* %49, align 4, !dbg !326, !tbaa !327
  %51 = tail call i32 @llvm.bswap.i32(i32 %50), !dbg !326
  call void @llvm.dbg.value(metadata i32 undef, metadata !270, metadata !DIExpression()), !dbg !328
  %52 = add i32 %51, -1, !dbg !329
  %53 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !330
  call void @llvm.dbg.value(metadata i32 %52, metadata !275, metadata !DIExpression()), !dbg !328
  %54 = bitcast %struct.HashTable* %3 to i8*, !dbg !332
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %54) #4, !dbg !332
  call void @llvm.dbg.declare(metadata %struct.HashTable* %3, metadata !276, metadata !DIExpression()), !dbg !333
  %55 = load i32, i32* %44, align 4, !dbg !334, !tbaa !335
  %56 = getelementptr inbounds %struct.HashTable, %struct.HashTable* %3, i64 0, i32 0, !dbg !336
  store i32 %55, i32* %56, align 4, !dbg !337, !tbaa !235
  %57 = getelementptr inbounds %struct.HashTable, %struct.HashTable* %3, i64 0, i32 1, !dbg !338
  store i32 %52, i32* %57, align 4, !dbg !339, !tbaa !246
  call void @llvm.dbg.value(metadata %struct.HashTable* %3, metadata !126, metadata !DIExpression()) #4, !dbg !340
  %58 = bitcast i32* %2 to i8*, !dbg !342
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %58) #4, !dbg !342
  call void @llvm.dbg.value(metadata i32 %55, metadata !127, metadata !DIExpression()) #4, !dbg !340
  store i32 %55, i32* %2, align 4, !dbg !343, !tbaa !241
  call void @llvm.dbg.value(metadata i32* %2, metadata !127, metadata !DIExpression(DW_OP_deref)) #4, !dbg !340
  %59 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @hash_table_map to i8*), i8* nonnull %58, i8* nonnull %54, i64 0) #4, !dbg !344
  %60 = load i32, i32* %57, align 4, !dbg !345, !tbaa !246
  %61 = load i32, i32* %2, align 4, !dbg !345, !tbaa !241
  call void @llvm.dbg.value(metadata i32 %61, metadata !127, metadata !DIExpression()) #4, !dbg !340
  %62 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @write_hash_table.____fmt, i64 0, i64 0), i32 34, i32 %60, i32 %61) #4, !dbg !345
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %58) #4, !dbg !346
  %63 = load i32, i32* %49, align 4, !dbg !347, !tbaa !327
  %64 = call i32 @llvm.bswap.i32(i32 %63), !dbg !347
  %65 = add i32 %64, 1, !dbg !347
  %66 = call i32 @llvm.bswap.i32(i32 %65), !dbg !347
  %67 = getelementptr inbounds [6 x i8], [6 x i8]* %21, i64 1, i64 2, !dbg !348
  %68 = bitcast i8* %67 to i32*, !dbg !348
  store i32 %66, i32* %68, align 4, !dbg !349, !tbaa !350
  %69 = call i32 @llvm.bswap.i32(i32 %52), !dbg !351
  store i32 %69, i32* %49, align 4, !dbg !352, !tbaa !327
  %70 = load i16, i16* %38, align 4, !dbg !353
  %71 = or i16 %70, 4096, !dbg !353
  store i16 %71, i16* %38, align 4, !dbg !353
  %72 = load i16, i16* %47, align 4, !dbg !354, !tbaa !355
  call void @llvm.dbg.value(metadata i16 %72, metadata !277, metadata !DIExpression()), !dbg !328
  %73 = load i16, i16* %33, align 2, !dbg !356, !tbaa !317
  store i16 %73, i16* %47, align 4, !dbg !357, !tbaa !355
  store i16 %72, i16* %33, align 2, !dbg !358, !tbaa !317
  %74 = load i32, i32* %44, align 4, !dbg !359, !tbaa !335
  call void @llvm.dbg.value(metadata i32 %74, metadata !278, metadata !DIExpression()), !dbg !328
  %75 = load i32, i32* %46, align 4, !dbg !360, !tbaa !361
  store i32 %75, i32* %44, align 4, !dbg !362, !tbaa !335
  store i32 %74, i32* %46, align 4, !dbg !363, !tbaa !361
  %76 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %4, i64 0, i32 0, i64 0, !dbg !364
  call void @llvm.lifetime.start.p0i8(i64 14, i8* nonnull %76), !dbg !364
  call void @llvm.dbg.declare(metadata %struct.ethhdr* %4, metadata !279, metadata !DIExpression()), !dbg !365
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(14) %76, i8* nonnull align 1 dereferenceable(14) %8, i64 14, i1 false), !dbg !366, !tbaa.struct !367
  %77 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 0, i32 0, i64 0, !dbg !370
  %78 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %4, i64 0, i32 1, i64 0, !dbg !370
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %77, i8* nonnull align 1 dereferenceable(6) %78, i64 6, i1 false), !dbg !370
  %79 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 0, i32 1, i64 0, !dbg !371
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %79, i8* nonnull align 1 dereferenceable(6) %76, i64 6, i1 false), !dbg !371
  %80 = load i8, i8* %10, align 4, !dbg !372
  %81 = shl i8 %80, 2, !dbg !373
  %82 = and i8 %81, 60, !dbg !373
  call void @llvm.dbg.value(metadata i8 %82, metadata !280, metadata !DIExpression()), !dbg !328
  %83 = add nsw i8 %82, -20, !dbg !374
  call void @llvm.memset.p0i8.i64(i8* nonnull align 4 dereferenceable(20) %22, i8 %83, i64 20, i1 false), !dbg !375
  call void @llvm.lifetime.end.p0i8(i64 14, i8* nonnull %76), !dbg !376
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %54) #4, !dbg !376
  br label %84

84:                                               ; preds = %31, %20, %24, %36, %28, %42, %16, %1
  %85 = phi i32 [ 2, %1 ], [ 2, %16 ], [ 1, %20 ], [ 2, %24 ], [ 3, %42 ], [ 1, %28 ], [ 2, %36 ], [ 1, %31 ], !dbg !281
  ret i32 %85, !dbg !377
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { norecurse nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!158, !159, !160}
!llvm.ident = !{!161}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "data_cookis_map", scope: !2, file: !3, line: 24, type: !106, isLocal: false, isDefinition: true)
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
!43 = !{!44, !47, !62, !60, !63, !82, !80}
!44 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !45, line: 31, baseType: !46)
!45 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!46 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !49, line: 163, size: 112, elements: !50)
!49 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!50 = !{!51, !56, !57}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !48, file: !49, line: 164, baseType: !52, size: 48)
!52 = !DICompositeType(tag: DW_TAG_array_type, baseType: !53, size: 48, elements: !54)
!53 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!54 = !{!55}
!55 = !DISubrange(count: 6)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !48, file: !49, line: 165, baseType: !52, size: 48, offset: 48)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !48, file: !49, line: 166, baseType: !58, size: 16, offset: 96)
!58 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !59, line: 25, baseType: !60)
!59 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!60 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !45, line: 24, baseType: !61)
!61 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!62 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !65, line: 86, size: 160, elements: !66)
!65 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!66 = !{!67, !69, !70, !71, !72, !73, !74, !75, !76, !78, !81}
!67 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !64, file: !65, line: 88, baseType: !68, size: 4, flags: DIFlagBitField, extraData: i64 0)
!68 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !45, line: 21, baseType: !53)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !64, file: !65, line: 89, baseType: !68, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !64, file: !65, line: 96, baseType: !68, size: 8, offset: 8)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !64, file: !65, line: 97, baseType: !58, size: 16, offset: 16)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !64, file: !65, line: 98, baseType: !58, size: 16, offset: 32)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !64, file: !65, line: 99, baseType: !58, size: 16, offset: 48)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !64, file: !65, line: 100, baseType: !68, size: 8, offset: 64)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !64, file: !65, line: 101, baseType: !68, size: 8, offset: 72)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !64, file: !65, line: 102, baseType: !77, size: 16, offset: 80)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !59, line: 31, baseType: !60)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !64, file: !65, line: 103, baseType: !79, size: 32, offset: 96)
!79 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !59, line: 27, baseType: !80)
!80 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !45, line: 27, baseType: !7)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !64, file: !65, line: 104, baseType: !79, size: 32, offset: 128)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !84, line: 25, size: 160, elements: !85)
!84 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!85 = !{!86, !87, !88, !89, !90, !91, !92, !93, !94, !95, !96, !97, !98, !99, !100, !101, !102}
!86 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !83, file: !84, line: 26, baseType: !58, size: 16)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !83, file: !84, line: 27, baseType: !58, size: 16, offset: 16)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !83, file: !84, line: 28, baseType: !79, size: 32, offset: 32)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !83, file: !84, line: 29, baseType: !79, size: 32, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !83, file: !84, line: 31, baseType: !60, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !83, file: !84, line: 32, baseType: !60, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !83, file: !84, line: 33, baseType: !60, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !83, file: !84, line: 34, baseType: !60, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !83, file: !84, line: 35, baseType: !60, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !83, file: !84, line: 36, baseType: !60, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !83, file: !84, line: 37, baseType: !60, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !83, file: !84, line: 38, baseType: !60, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !83, file: !84, line: 39, baseType: !60, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !83, file: !84, line: 40, baseType: !60, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !83, file: !84, line: 55, baseType: !58, size: 16, offset: 112)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !83, file: !84, line: 56, baseType: !77, size: 16, offset: 128)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !83, file: !84, line: 57, baseType: !58, size: 16, offset: 144)
!103 = !{!0, !104, !114, !133, !138, !144, !152}
!104 = !DIGlobalVariableExpression(var: !105, expr: !DIExpression())
!105 = distinct !DIGlobalVariable(name: "hash_table_map", scope: !2, file: !3, line: 32, type: !106, isLocal: false, isDefinition: true)
!106 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !107, line: 154, size: 160, elements: !108)
!107 = !DIFile(filename: "/usr/include/bpf/bpf_helpers.h", directory: "")
!108 = !{!109, !110, !111, !112, !113}
!109 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !106, file: !107, line: 155, baseType: !7, size: 32)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !106, file: !107, line: 156, baseType: !7, size: 32, offset: 32)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !106, file: !107, line: 157, baseType: !7, size: 32, offset: 64)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !106, file: !107, line: 158, baseType: !7, size: 32, offset: 96)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !106, file: !107, line: 159, baseType: !7, size: 32, offset: 128)
!114 = !DIGlobalVariableExpression(var: !115, expr: !DIExpression())
!115 = distinct !DIGlobalVariable(name: "____fmt", scope: !116, file: !3, line: 56, type: !128, isLocal: true, isDefinition: true)
!116 = distinct !DISubprogram(name: "write_hash_table", scope: !3, file: !3, line: 52, type: !117, scopeLine: 52, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !125)
!117 = !DISubroutineType(types: !118)
!118 = !{null, !119}
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "HashTable", file: !121, line: 10, size: 64, elements: !122)
!121 = !DIFile(filename: "./common_struct.h", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/XDP_syn_cookie")
!122 = !{!123, !124}
!123 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !120, file: !121, line: 11, baseType: !80, size: 32)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "cookie", scope: !120, file: !121, line: 12, baseType: !80, size: 32, offset: 32)
!125 = !{!126, !127}
!126 = !DILocalVariable(name: "data", arg: 1, scope: !116, file: !3, line: 52, type: !119)
!127 = !DILocalVariable(name: "key", scope: !116, file: !3, line: 53, type: !80)
!128 = !DICompositeType(tag: DW_TAG_array_type, baseType: !129, size: 272, elements: !131)
!129 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !130)
!130 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!131 = !{!132}
!132 = !DISubrange(count: 34)
!133 = !DIGlobalVariableExpression(var: !134, expr: !DIExpression())
!134 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 143, type: !135, isLocal: false, isDefinition: true)
!135 = !DICompositeType(tag: DW_TAG_array_type, baseType: !130, size: 32, elements: !136)
!136 = !{!137}
!137 = !DISubrange(count: 4)
!138 = !DIGlobalVariableExpression(var: !139, expr: !DIExpression())
!139 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !140, line: 109, type: !141, isLocal: true, isDefinition: true)
!140 = !DIFile(filename: "/usr/include/bpf/bpf_helper_defs.h", directory: "")
!141 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !142, size: 64)
!142 = !DISubroutineType(types: !143)
!143 = !{!44}
!144 = !DIGlobalVariableExpression(var: !145, expr: !DIExpression())
!145 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !140, line: 73, type: !146, isLocal: true, isDefinition: true)
!146 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !147, size: 64)
!147 = !DISubroutineType(types: !148)
!148 = !{!149, !62, !150, !150, !44}
!149 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!150 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !151, size: 64)
!151 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!152 = !DIGlobalVariableExpression(var: !153, expr: !DIExpression())
!153 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !140, line: 172, type: !154, isLocal: true, isDefinition: true)
!154 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !155, size: 64)
!155 = !DISubroutineType(types: !156)
!156 = !{!149, !157, !80, null}
!157 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 64)
!158 = !{i32 7, !"Dwarf Version", i32 4}
!159 = !{i32 2, !"Debug Info Version", i32 3}
!160 = !{i32 1, !"wchar_size", i32 4}
!161 = !{!"clang version 10.0.0-4ubuntu1 "}
!162 = distinct !DISubprogram(name: "hash_32", scope: !163, file: !163, line: 6, type: !164, scopeLine: 6, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !167)
!163 = !DIFile(filename: "./hash_cookie.h", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/XDP_syn_cookie")
!164 = !DISubroutineType(types: !165)
!165 = !{!80, !166, !60}
!166 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !80)
!167 = !{!168, !169, !170}
!168 = !DILocalVariable(name: "buf", arg: 1, scope: !162, file: !163, line: 6, type: !166)
!169 = !DILocalVariable(name: "size", arg: 2, scope: !162, file: !163, line: 6, type: !60)
!170 = !DILocalVariable(name: "hash", scope: !162, file: !163, line: 7, type: !80)
!171 = !DILocation(line: 0, scope: !162)
!172 = !DILocation(line: 7, column: 22, scope: !162)
!173 = !DILocation(line: 8, column: 26, scope: !162)
!174 = !DILocation(line: 8, column: 24, scope: !162)
!175 = !DILocation(line: 8, column: 17, scope: !162)
!176 = !DILocation(line: 8, column: 5, scope: !162)
!177 = distinct !DISubprogram(name: "hash_tcp_ip", scope: !163, file: !163, line: 13, type: !178, scopeLine: 13, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !180)
!178 = !DISubroutineType(types: !179)
!179 = !{!80, !80, !80, !60, !60, !80}
!180 = !{!181, !182, !183, !184, !185, !186, !187}
!181 = !DILocalVariable(name: "saddr", arg: 1, scope: !177, file: !163, line: 13, type: !80)
!182 = !DILocalVariable(name: "daddr", arg: 2, scope: !177, file: !163, line: 13, type: !80)
!183 = !DILocalVariable(name: "sport", arg: 3, scope: !177, file: !163, line: 13, type: !60)
!184 = !DILocalVariable(name: "dport", arg: 4, scope: !177, file: !163, line: 13, type: !60)
!185 = !DILocalVariable(name: "seqnum", arg: 5, scope: !177, file: !163, line: 13, type: !80)
!186 = !DILocalVariable(name: "cookie_seed", scope: !177, file: !163, line: 14, type: !80)
!187 = !DILocalVariable(name: "res", scope: !177, file: !163, line: 15, type: !80)
!188 = !DILocation(line: 0, scope: !177)
!189 = !DILocation(line: 17, column: 5, scope: !177)
!190 = distinct !DISubprogram(name: "hash_cookie", scope: !163, file: !163, line: 21, type: !191, scopeLine: 21, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !193)
!191 = !DISubroutineType(types: !192)
!192 = !{!80, !80, !80, !80}
!193 = !{!194, !195, !196}
!194 = !DILocalVariable(name: "hash", arg: 1, scope: !190, file: !163, line: 21, type: !80)
!195 = !DILocalVariable(name: "seqnum", arg: 2, scope: !190, file: !163, line: 21, type: !80)
!196 = !DILocalVariable(name: "count", arg: 3, scope: !190, file: !163, line: 21, type: !80)
!197 = !DILocation(line: 0, scope: !190)
!198 = !DILocation(line: 0, scope: !162, inlinedAt: !199)
!199 = distinct !DILocation(line: 22, column: 21, scope: !190)
!200 = !DILocation(line: 7, column: 22, scope: !162, inlinedAt: !199)
!201 = !DILocation(line: 8, column: 26, scope: !162, inlinedAt: !199)
!202 = !DILocation(line: 8, column: 24, scope: !162, inlinedAt: !199)
!203 = !DILocation(line: 8, column: 17, scope: !162, inlinedAt: !199)
!204 = !DILocation(line: 22, column: 19, scope: !190)
!205 = !DILocation(line: 22, column: 5, scope: !190)
!206 = distinct !DISubprogram(name: "verify_cookies", scope: !163, file: !163, line: 27, type: !207, scopeLine: 27, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !210)
!207 = !DISubroutineType(types: !208)
!208 = !{!209, !80, !80, !80, !80}
!209 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!210 = !{!211, !212, !213, !214}
!211 = !DILocalVariable(name: "hash", arg: 1, scope: !206, file: !163, line: 27, type: !80)
!212 = !DILocalVariable(name: "seqnum", arg: 2, scope: !206, file: !163, line: 27, type: !80)
!213 = !DILocalVariable(name: "cookie", arg: 3, scope: !206, file: !163, line: 27, type: !80)
!214 = !DILocalVariable(name: "count", arg: 4, scope: !206, file: !163, line: 27, type: !80)
!215 = !DILocation(line: 0, scope: !206)
!216 = !DILocation(line: 28, column: 12, scope: !206)
!217 = !DILocation(line: 0, scope: !162, inlinedAt: !218)
!218 = distinct !DILocation(line: 30, column: 22, scope: !206)
!219 = !DILocation(line: 7, column: 22, scope: !162, inlinedAt: !218)
!220 = !DILocation(line: 8, column: 26, scope: !162, inlinedAt: !218)
!221 = !DILocation(line: 8, column: 24, scope: !162, inlinedAt: !218)
!222 = !DILocation(line: 8, column: 17, scope: !162, inlinedAt: !218)
!223 = !DILocation(line: 30, column: 19, scope: !206)
!224 = !DILocation(line: 30, column: 5, scope: !206)
!225 = distinct !DISubprogram(name: "cookie_counter", scope: !3, file: !3, line: 40, type: !226, scopeLine: 40, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !228)
!226 = !DISubroutineType(types: !227)
!227 = !{!80}
!228 = !{}
!229 = !DILocation(line: 41, column: 12, scope: !225)
!230 = !DILocation(line: 41, column: 31, scope: !225)
!231 = !DILocation(line: 41, column: 5, scope: !225)
!232 = !DILocation(line: 0, scope: !116)
!233 = !DILocation(line: 53, column: 5, scope: !116)
!234 = !DILocation(line: 53, column: 23, scope: !116)
!235 = !{!236, !237, i64 0}
!236 = !{!"HashTable", !237, i64 0, !237, i64 4}
!237 = !{!"int", !238, i64 0}
!238 = !{!"omnipotent char", !239, i64 0}
!239 = !{!"Simple C/C++ TBAA"}
!240 = !DILocation(line: 53, column: 11, scope: !116)
!241 = !{!237, !237, i64 0}
!242 = !DILocation(line: 55, column: 48, scope: !116)
!243 = !DILocation(line: 55, column: 5, scope: !116)
!244 = !DILocation(line: 56, column: 5, scope: !245)
!245 = distinct !DILexicalBlock(scope: !116, file: !3, line: 56, column: 5)
!246 = !{!236, !237, i64 4}
!247 = !DILocation(line: 57, column: 1, scope: !116)
!248 = distinct !DISubprogram(name: "xdp_main", scope: !3, file: !3, line: 62, type: !249, scopeLine: 62, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !259)
!249 = !DISubroutineType(types: !250)
!250 = !{!209, !251}
!251 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !252, size: 64)
!252 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !253)
!253 = !{!254, !255, !256, !257, !258}
!254 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !252, file: !6, line: 2857, baseType: !80, size: 32)
!255 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !252, file: !6, line: 2858, baseType: !80, size: 32, offset: 32)
!256 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !252, file: !6, line: 2859, baseType: !80, size: 32, offset: 64)
!257 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !252, file: !6, line: 2861, baseType: !80, size: 32, offset: 96)
!258 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !252, file: !6, line: 2862, baseType: !80, size: 32, offset: 128)
!259 = !{!260, !261, !268, !269, !270, !275, !276, !277, !278, !279, !280}
!260 = !DILocalVariable(name: "ctx", arg: 1, scope: !248, file: !3, line: 62, type: !251)
!261 = !DILocalVariable(name: "Npack", scope: !248, file: !3, line: 63, type: !262)
!262 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "NetPacket", file: !3, line: 16, size: 256, elements: !263)
!263 = !{!264, !265, !266, !267}
!264 = !DIDerivedType(tag: DW_TAG_member, name: "ctx", scope: !262, file: !3, line: 17, baseType: !251, size: 64)
!265 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4", scope: !262, file: !3, line: 18, baseType: !63, size: 64, offset: 64)
!266 = !DIDerivedType(tag: DW_TAG_member, name: "tcp", scope: !262, file: !3, line: 19, baseType: !82, size: 64, offset: 128)
!267 = !DIDerivedType(tag: DW_TAG_member, name: "eth", scope: !262, file: !3, line: 20, baseType: !47, size: 64, offset: 192)
!268 = !DILocalVariable(name: "ipv4", scope: !248, file: !3, line: 78, type: !63)
!269 = !DILocalVariable(name: "tcp", scope: !248, file: !3, line: 90, type: !82)
!270 = !DILocalVariable(name: "hash", scope: !271, file: !3, line: 99, type: !80)
!271 = distinct !DILexicalBlock(scope: !272, file: !3, line: 98, column: 28)
!272 = distinct !DILexicalBlock(scope: !273, file: !3, line: 98, column: 12)
!273 = distinct !DILexicalBlock(scope: !274, file: !3, line: 97, column: 84)
!274 = distinct !DILexicalBlock(scope: !248, file: !3, line: 97, column: 9)
!275 = !DILocalVariable(name: "cookie", scope: !271, file: !3, line: 100, type: !80)
!276 = !DILocalVariable(name: "data", scope: !271, file: !3, line: 102, type: !120)
!277 = !DILocalVariable(name: "temp_sport", scope: !271, file: !3, line: 113, type: !60)
!278 = !DILocalVariable(name: "temp_saddr", scope: !271, file: !3, line: 117, type: !80)
!279 = !DILocalVariable(name: "temp_eth", scope: !271, file: !3, line: 122, type: !48)
!280 = !DILocalVariable(name: "ipv4_size", scope: !271, file: !3, line: 127, type: !80)
!281 = !DILocation(line: 0, scope: !248)
!282 = !DILocation(line: 65, column: 45, scope: !248)
!283 = !{!284, !237, i64 0}
!284 = !{!"xdp_md", !237, i64 0, !237, i64 4, !237, i64 8, !237, i64 12, !237, i64 16}
!285 = !DILocation(line: 65, column: 33, scope: !248)
!286 = !DILocation(line: 65, column: 17, scope: !248)
!287 = !DILocation(line: 68, column: 8, scope: !288)
!288 = distinct !DILexicalBlock(scope: !248, file: !3, line: 68, column: 8)
!289 = !DILocation(line: 68, column: 45, scope: !288)
!290 = !{!284, !237, i64 4}
!291 = !DILocation(line: 68, column: 33, scope: !288)
!292 = !DILocation(line: 68, column: 31, scope: !288)
!293 = !DILocation(line: 68, column: 8, scope: !248)
!294 = !DILocation(line: 73, column: 19, scope: !295)
!295 = distinct !DILexicalBlock(scope: !248, file: !3, line: 73, column: 8)
!296 = !{!297, !298, i64 12}
!297 = !{!"ethhdr", !238, i64 0, !238, i64 6, !298, i64 12}
!298 = !{!"short", !238, i64 0}
!299 = !DILocation(line: 73, column: 27, scope: !295)
!300 = !DILocation(line: 73, column: 8, scope: !248)
!301 = !DILocation(line: 79, column: 21, scope: !302)
!302 = distinct !DILexicalBlock(scope: !248, file: !3, line: 79, column: 8)
!303 = !DILocation(line: 79, column: 8, scope: !302)
!304 = !DILocation(line: 79, column: 26, scope: !302)
!305 = !DILocation(line: 79, column: 8, scope: !248)
!306 = !DILocation(line: 85, column: 20, scope: !307)
!307 = distinct !DILexicalBlock(scope: !248, file: !3, line: 85, column: 8)
!308 = !{!309, !238, i64 9}
!309 = !{!"iphdr", !238, i64 0, !238, i64 0, !238, i64 1, !298, i64 2, !298, i64 4, !298, i64 6, !238, i64 8, !238, i64 9, !298, i64 10, !237, i64 12, !237, i64 16}
!310 = !DILocation(line: 85, column: 29, scope: !307)
!311 = !DILocation(line: 85, column: 8, scope: !248)
!312 = !DILocation(line: 91, column: 20, scope: !313)
!313 = distinct !DILexicalBlock(scope: !248, file: !3, line: 91, column: 8)
!314 = !DILocation(line: 91, column: 25, scope: !313)
!315 = !DILocation(line: 91, column: 8, scope: !248)
!316 = !DILocation(line: 97, column: 10, scope: !274)
!317 = !{!318, !298, i64 2}
!318 = !{!"tcphdr", !298, i64 0, !298, i64 2, !237, i64 4, !237, i64 8, !298, i64 12, !298, i64 12, !298, i64 13, !298, i64 13, !298, i64 13, !298, i64 13, !298, i64 13, !298, i64 13, !298, i64 13, !298, i64 13, !298, i64 14, !298, i64 16, !298, i64 18}
!319 = !DILocation(line: 97, column: 44, scope: !274)
!320 = !DILocation(line: 98, column: 23, scope: !272)
!321 = !DILocation(line: 98, column: 12, scope: !272)
!322 = !DILocation(line: 98, column: 12, scope: !273)
!323 = !DILocation(line: 99, column: 50, scope: !271)
!324 = !DILocation(line: 99, column: 69, scope: !271)
!325 = !DILocation(line: 99, column: 87, scope: !271)
!326 = !DILocation(line: 99, column: 112, scope: !271)
!327 = !{!318, !237, i64 4}
!328 = !DILocation(line: 0, scope: !271)
!329 = !DILocation(line: 100, column: 72, scope: !271)
!330 = !DILocation(line: 41, column: 12, scope: !225, inlinedAt: !331)
!331 = distinct !DILocation(line: 100, column: 77, scope: !271)
!332 = !DILocation(line: 102, column: 13, scope: !271)
!333 = !DILocation(line: 102, column: 30, scope: !271)
!334 = !DILocation(line: 103, column: 38, scope: !271)
!335 = !{!309, !237, i64 12}
!336 = !DILocation(line: 103, column: 18, scope: !271)
!337 = !DILocation(line: 103, column: 24, scope: !271)
!338 = !DILocation(line: 104, column: 18, scope: !271)
!339 = !DILocation(line: 104, column: 25, scope: !271)
!340 = !DILocation(line: 0, scope: !116, inlinedAt: !341)
!341 = distinct !DILocation(line: 106, column: 13, scope: !271)
!342 = !DILocation(line: 53, column: 5, scope: !116, inlinedAt: !341)
!343 = !DILocation(line: 53, column: 11, scope: !116, inlinedAt: !341)
!344 = !DILocation(line: 55, column: 5, scope: !116, inlinedAt: !341)
!345 = !DILocation(line: 56, column: 5, scope: !245, inlinedAt: !341)
!346 = !DILocation(line: 57, column: 1, scope: !116, inlinedAt: !341)
!347 = !DILocation(line: 109, column: 34, scope: !271)
!348 = !DILocation(line: 109, column: 24, scope: !271)
!349 = !DILocation(line: 109, column: 32, scope: !271)
!350 = !{!318, !237, i64 8}
!351 = !DILocation(line: 110, column: 30, scope: !271)
!352 = !DILocation(line: 110, column: 28, scope: !271)
!353 = !DILocation(line: 111, column: 28, scope: !271)
!354 = !DILocation(line: 113, column: 43, scope: !271)
!355 = !{!318, !298, i64 0}
!356 = !DILocation(line: 114, column: 44, scope: !271)
!357 = !DILocation(line: 114, column: 31, scope: !271)
!358 = !DILocation(line: 115, column: 29, scope: !271)
!359 = !DILocation(line: 117, column: 44, scope: !271)
!360 = !DILocation(line: 118, column: 45, scope: !271)
!361 = !{!309, !237, i64 16}
!362 = !DILocation(line: 118, column: 31, scope: !271)
!363 = !DILocation(line: 119, column: 31, scope: !271)
!364 = !DILocation(line: 122, column: 13, scope: !271)
!365 = !DILocation(line: 122, column: 27, scope: !271)
!366 = !DILocation(line: 122, column: 38, scope: !271)
!367 = !{i64 0, i64 6, !368, i64 6, i64 6, !368, i64 12, i64 2, !369}
!368 = !{!238, !238, i64 0}
!369 = !{!298, !298, i64 0}
!370 = !DILocation(line: 123, column: 13, scope: !271)
!371 = !DILocation(line: 124, column: 13, scope: !271)
!372 = !DILocation(line: 127, column: 43, scope: !271)
!373 = !DILocation(line: 127, column: 47, scope: !271)
!374 = !DILocation(line: 128, column: 46, scope: !271)
!375 = !DILocation(line: 128, column: 13, scope: !271)
!376 = !DILocation(line: 131, column: 9, scope: !272)
!377 = !DILocation(line: 141, column: 1, scope: !248)
