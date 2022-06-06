; ModuleID = 'xdp_kern.c'
source_filename = "xdp_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.DataCookie = type { i32, i32, i16, i16, i32, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@data_cookis_map = dso_local global %struct.bpf_map_def { i32 1, i32 4, i32 24, i32 1024, i32 0 }, section "maps", align 4, !dbg !0
@write_hash_table.____fmt = internal constant [34 x i8] c"Uspeshno dobavili %x\0A     key: %d\00", align 1, !dbg !102
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !127
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.bpf_map_def* @data_cookis_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_main to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @cookie_counter() local_unnamed_addr #0 !dbg !164 {
  %1 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !168
  %2 = lshr i64 %1, 33, !dbg !169
  %3 = trunc i64 %2 to i32, !dbg !168
  ret i32 %3, !dbg !170
}

; Function Attrs: nounwind
define dso_local void @write_hash_table(%struct.DataCookie* %0) local_unnamed_addr #0 !dbg !104 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.DataCookie* %0, metadata !120, metadata !DIExpression()), !dbg !171
  %3 = bitcast i32* %2 to i8*, !dbg !172
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #3, !dbg !172
  %4 = getelementptr inbounds %struct.DataCookie, %struct.DataCookie* %0, i64 0, i32 0, !dbg !173
  %5 = load i32, i32* %4, align 8, !dbg !173, !tbaa !174
  call void @llvm.dbg.value(metadata i32 %5, metadata !121, metadata !DIExpression()), !dbg !171
  store i32 %5, i32* %2, align 4, !dbg !181, !tbaa !182
  %6 = bitcast %struct.DataCookie* %0 to i8*, !dbg !183
  call void @llvm.dbg.value(metadata i32* %2, metadata !121, metadata !DIExpression(DW_OP_deref)), !dbg !171
  %7 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @data_cookis_map to i8*), i8* nonnull %3, i8* %6, i64 1) #3, !dbg !184
  %8 = load i32, i32* %4, align 8, !dbg !185, !tbaa !174
  %9 = load i32, i32* %2, align 4, !dbg !185, !tbaa !182
  call void @llvm.dbg.value(metadata i32 %9, metadata !121, metadata !DIExpression()), !dbg !171
  %10 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @write_hash_table.____fmt, i64 0, i64 0), i32 34, i32 %8, i32 %9) #3, !dbg !185
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #3, !dbg !187
  ret void, !dbg !187
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind
define dso_local i32 @xdp_main(%struct.xdp_md* nocapture readonly %0) #0 section "prog" !dbg !188 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.DataCookie, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !201, metadata !DIExpression()), !dbg !216
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !202, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !216
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !217
  %5 = load i32, i32* %4, align 4, !dbg !217, !tbaa !218
  %6 = zext i32 %5 to i64, !dbg !220
  %7 = inttoptr i64 %6 to %struct.ethhdr*, !dbg !221
  call void @llvm.dbg.value(metadata %struct.ethhdr* %7, metadata !202, metadata !DIExpression(DW_OP_LLVM_fragment, 192, 64)), !dbg !216
  %8 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %7, i64 1, i32 0, i64 0, !dbg !222
  %9 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !224
  %10 = load i32, i32* %9, align 4, !dbg !224, !tbaa !225
  %11 = zext i32 %10 to i64, !dbg !226
  %12 = inttoptr i64 %11 to i8*, !dbg !226
  %13 = icmp ugt i8* %8, %12, !dbg !227
  br i1 %13, label %68, label %14, !dbg !228

14:                                               ; preds = %1
  %15 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %7, i64 0, i32 2, !dbg !229
  %16 = load i16, i16* %15, align 1, !dbg !229, !tbaa !231
  %17 = icmp eq i16 %16, 8, !dbg !233
  br i1 %17, label %18, label %68, !dbg !234

18:                                               ; preds = %14
  call void @llvm.dbg.value(metadata %struct.ethhdr* %7, metadata !209, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !216
  %19 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %7, i64 2, i32 1, !dbg !235
  %20 = getelementptr [6 x i8], [6 x i8]* %19, i64 0, i64 0, !dbg !237
  %21 = icmp ugt i8* %20, %12, !dbg !238
  br i1 %21, label %68, label %22, !dbg !239

22:                                               ; preds = %18
  call void @llvm.dbg.value(metadata %struct.ethhdr* %7, metadata !202, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value, DW_OP_LLVM_fragment, 64, 64)), !dbg !216
  %23 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %7, i64 1, i32 1, i64 3, !dbg !240
  %24 = load i8, i8* %23, align 1, !dbg !240, !tbaa !242
  %25 = icmp eq i8 %24, 6, !dbg !244
  br i1 %25, label %26, label %68, !dbg !245

26:                                               ; preds = %22
  call void @llvm.dbg.value(metadata [6 x i8]* %19, metadata !210, metadata !DIExpression()), !dbg !216
  %27 = getelementptr inbounds [6 x i8], [6 x i8]* %19, i64 3, i64 2, !dbg !246
  %28 = icmp ugt i8* %27, %12, !dbg !248
  br i1 %28, label %68, label %29, !dbg !249

29:                                               ; preds = %26
  call void @llvm.dbg.value(metadata [6 x i8]* %19, metadata !202, metadata !DIExpression(DW_OP_LLVM_fragment, 128, 64)), !dbg !216
  %30 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %7, i64 2, i32 1, i64 2, !dbg !250
  %31 = bitcast i8* %30 to i16*, !dbg !250
  %32 = load i16, i16* %31, align 2, !dbg !250, !tbaa !251
  %33 = tail call i16 @llvm.bswap.i16(i16 %32)
  switch i16 %33, label %68 [
    i16 80, label %34
    i16 443, label %34
  ], !dbg !253

34:                                               ; preds = %29, %29
  %35 = getelementptr inbounds [6 x i8], [6 x i8]* %19, i64 2, !dbg !254
  %36 = bitcast [6 x i8]* %35 to i16*, !dbg !254
  %37 = load i16, i16* %36, align 4, !dbg !254
  %38 = and i16 %37, 512, !dbg !254
  %39 = icmp eq i16 %38, 0, !dbg !255
  br i1 %39, label %68, label %40, !dbg !256

40:                                               ; preds = %34
  %41 = bitcast %struct.DataCookie* %3 to i8*, !dbg !257
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %41) #3, !dbg !257
  call void @llvm.dbg.declare(metadata %struct.DataCookie* %3, metadata !211, metadata !DIExpression()), !dbg !258
  %42 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %7, i64 1, i32 2, !dbg !259
  %43 = bitcast i16* %42 to i32*, !dbg !259
  %44 = load i32, i32* %43, align 4, !dbg !259, !tbaa !182
  %45 = getelementptr inbounds %struct.DataCookie, %struct.DataCookie* %3, i64 0, i32 0, !dbg !260
  store i32 %44, i32* %45, align 8, !dbg !261, !tbaa !174
  %46 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %7, i64 2, i32 0, i64 2, !dbg !262
  %47 = bitcast i8* %46 to i32*, !dbg !262
  %48 = load i32, i32* %47, align 4, !dbg !262, !tbaa !263
  %49 = getelementptr inbounds %struct.DataCookie, %struct.DataCookie* %3, i64 0, i32 1, !dbg !264
  store i32 %48, i32* %49, align 4, !dbg !265, !tbaa !266
  %50 = bitcast [6 x i8]* %19 to i16*, !dbg !267
  %51 = load i16, i16* %50, align 4, !dbg !267, !tbaa !268
  %52 = getelementptr inbounds %struct.DataCookie, %struct.DataCookie* %3, i64 0, i32 2, !dbg !269
  store i16 %51, i16* %52, align 8, !dbg !270, !tbaa !271
  %53 = getelementptr inbounds %struct.DataCookie, %struct.DataCookie* %3, i64 0, i32 3, !dbg !272
  store i16 %32, i16* %53, align 2, !dbg !273, !tbaa !274
  %54 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %7, i64 2, i32 1, i64 4, !dbg !275
  %55 = bitcast i8* %54 to i32*, !dbg !275
  %56 = load i32, i32* %55, align 4, !dbg !275, !tbaa !276
  %57 = tail call i32 @llvm.bswap.i32(i32 %56), !dbg !275
  %58 = add i32 %57, -1, !dbg !277
  %59 = getelementptr inbounds %struct.DataCookie, %struct.DataCookie* %3, i64 0, i32 4, !dbg !278
  store i32 %58, i32* %59, align 4, !dbg !279, !tbaa !280
  %60 = tail call i64 inttoptr (i64 5 to i64 ()*)() #3, !dbg !281
  %61 = lshr i64 %60, 33, !dbg !283
  %62 = getelementptr inbounds %struct.DataCookie, %struct.DataCookie* %3, i64 0, i32 5, !dbg !284
  store i64 %61, i64* %62, align 8, !dbg !285, !tbaa !286
  call void @llvm.dbg.value(metadata %struct.DataCookie* %3, metadata !120, metadata !DIExpression()) #3, !dbg !287
  %63 = bitcast i32* %2 to i8*, !dbg !289
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %63) #3, !dbg !289
  call void @llvm.dbg.value(metadata i32 %44, metadata !121, metadata !DIExpression()) #3, !dbg !287
  store i32 %44, i32* %2, align 4, !dbg !290, !tbaa !182
  call void @llvm.dbg.value(metadata i32* %2, metadata !121, metadata !DIExpression(DW_OP_deref)) #3, !dbg !287
  %64 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.bpf_map_def* @data_cookis_map to i8*), i8* nonnull %63, i8* nonnull %41, i64 1) #3, !dbg !291
  %65 = load i32, i32* %45, align 8, !dbg !292, !tbaa !174
  %66 = load i32, i32* %2, align 4, !dbg !292, !tbaa !182
  call void @llvm.dbg.value(metadata i32 %66, metadata !121, metadata !DIExpression()) #3, !dbg !287
  %67 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @write_hash_table.____fmt, i64 0, i64 0), i32 34, i32 %65, i32 %66) #3, !dbg !292
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %63) #3, !dbg !293
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %41) #3, !dbg !294
  br label %68

68:                                               ; preds = %29, %18, %22, %34, %26, %40, %14, %1
  %69 = phi i32 [ 2, %1 ], [ 2, %14 ], [ 1, %18 ], [ 2, %22 ], [ 1, %40 ], [ 1, %26 ], [ 2, %34 ], [ 1, %29 ], !dbg !216
  ret i32 %69, !dbg !295
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!160, !161, !162}
!llvm.ident = !{!163}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "data_cookis_map", scope: !2, file: !3, line: 23, type: !152, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !43, globals: !101, splitDebugInlining: false, nameTableKind: None)
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
!43 = !{!44, !60, !57, !61, !80, !78}
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!45 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !46, line: 163, size: 112, elements: !47)
!46 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!47 = !{!48, !53, !54}
!48 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !45, file: !46, line: 164, baseType: !49, size: 48)
!49 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 48, elements: !51)
!50 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!51 = !{!52}
!52 = !DISubrange(count: 6)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !45, file: !46, line: 165, baseType: !49, size: 48, offset: 48)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !45, file: !46, line: 166, baseType: !55, size: 16, offset: 96)
!55 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !56, line: 25, baseType: !57)
!56 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!57 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !58, line: 24, baseType: !59)
!58 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!59 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!61 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !62, size: 64)
!62 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !63, line: 86, size: 160, elements: !64)
!63 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!64 = !{!65, !67, !68, !69, !70, !71, !72, !73, !74, !76, !79}
!65 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !62, file: !63, line: 88, baseType: !66, size: 4, flags: DIFlagBitField, extraData: i64 0)
!66 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !58, line: 21, baseType: !50)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !62, file: !63, line: 89, baseType: !66, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !62, file: !63, line: 96, baseType: !66, size: 8, offset: 8)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !62, file: !63, line: 97, baseType: !55, size: 16, offset: 16)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !62, file: !63, line: 98, baseType: !55, size: 16, offset: 32)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !62, file: !63, line: 99, baseType: !55, size: 16, offset: 48)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !62, file: !63, line: 100, baseType: !66, size: 8, offset: 64)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !62, file: !63, line: 101, baseType: !66, size: 8, offset: 72)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !62, file: !63, line: 102, baseType: !75, size: 16, offset: 80)
!75 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !56, line: 31, baseType: !57)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !62, file: !63, line: 103, baseType: !77, size: 32, offset: 96)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !56, line: 27, baseType: !78)
!78 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !58, line: 27, baseType: !7)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !62, file: !63, line: 104, baseType: !77, size: 32, offset: 128)
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !82, line: 25, size: 160, elements: !83)
!82 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!83 = !{!84, !85, !86, !87, !88, !89, !90, !91, !92, !93, !94, !95, !96, !97, !98, !99, !100}
!84 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !81, file: !82, line: 26, baseType: !55, size: 16)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !81, file: !82, line: 27, baseType: !55, size: 16, offset: 16)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !81, file: !82, line: 28, baseType: !77, size: 32, offset: 32)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !81, file: !82, line: 29, baseType: !77, size: 32, offset: 64)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !81, file: !82, line: 31, baseType: !57, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !81, file: !82, line: 32, baseType: !57, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !81, file: !82, line: 33, baseType: !57, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !81, file: !82, line: 34, baseType: !57, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !81, file: !82, line: 35, baseType: !57, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !81, file: !82, line: 36, baseType: !57, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !81, file: !82, line: 37, baseType: !57, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !81, file: !82, line: 38, baseType: !57, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !81, file: !82, line: 39, baseType: !57, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !81, file: !82, line: 40, baseType: !57, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !81, file: !82, line: 55, baseType: !55, size: 16, offset: 112)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !81, file: !82, line: 56, baseType: !75, size: 16, offset: 128)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !81, file: !82, line: 57, baseType: !55, size: 16, offset: 144)
!101 = !{!0, !102, !127, !132, !138, !146}
!102 = !DIGlobalVariableExpression(var: !103, expr: !DIExpression())
!103 = distinct !DIGlobalVariable(name: "____fmt", scope: !104, file: !3, line: 40, type: !122, isLocal: true, isDefinition: true)
!104 = distinct !DISubprogram(name: "write_hash_table", scope: !3, file: !3, line: 36, type: !105, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !119)
!105 = !DISubroutineType(types: !106)
!106 = !{null, !107}
!107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !108, size: 64)
!108 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "DataCookie", file: !109, line: 1, size: 192, elements: !110)
!109 = !DIFile(filename: "./common_struct.h", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/XDP_syn_cookie")
!110 = !{!111, !112, !113, !114, !115, !116}
!111 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !108, file: !109, line: 2, baseType: !78, size: 32)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !108, file: !109, line: 3, baseType: !78, size: 32, offset: 32)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "sport", scope: !108, file: !109, line: 4, baseType: !57, size: 16, offset: 64)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "dport", scope: !108, file: !109, line: 5, baseType: !57, size: 16, offset: 80)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "seqnum", scope: !108, file: !109, line: 6, baseType: !78, size: 32, offset: 96)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "time", scope: !108, file: !109, line: 7, baseType: !117, size: 64, offset: 128)
!117 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !58, line: 31, baseType: !118)
!118 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!119 = !{!120, !121}
!120 = !DILocalVariable(name: "data", arg: 1, scope: !104, file: !3, line: 36, type: !107)
!121 = !DILocalVariable(name: "key", scope: !104, file: !3, line: 37, type: !78)
!122 = !DICompositeType(tag: DW_TAG_array_type, baseType: !123, size: 272, elements: !125)
!123 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !124)
!124 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!125 = !{!126}
!126 = !DISubrange(count: 34)
!127 = !DIGlobalVariableExpression(var: !128, expr: !DIExpression())
!128 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 105, type: !129, isLocal: false, isDefinition: true)
!129 = !DICompositeType(tag: DW_TAG_array_type, baseType: !124, size: 32, elements: !130)
!130 = !{!131}
!131 = !DISubrange(count: 4)
!132 = !DIGlobalVariableExpression(var: !133, expr: !DIExpression())
!133 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !134, line: 109, type: !135, isLocal: true, isDefinition: true)
!134 = !DIFile(filename: "/usr/include/bpf/bpf_helper_defs.h", directory: "")
!135 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !136, size: 64)
!136 = !DISubroutineType(types: !137)
!137 = !{!117}
!138 = !DIGlobalVariableExpression(var: !139, expr: !DIExpression())
!139 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !134, line: 73, type: !140, isLocal: true, isDefinition: true)
!140 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !141, size: 64)
!141 = !DISubroutineType(types: !142)
!142 = !{!143, !60, !144, !144, !117}
!143 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!144 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !145, size: 64)
!145 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!146 = !DIGlobalVariableExpression(var: !147, expr: !DIExpression())
!147 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !134, line: 172, type: !148, isLocal: true, isDefinition: true)
!148 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !149, size: 64)
!149 = !DISubroutineType(types: !150)
!150 = !{!143, !151, !78, null}
!151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !123, size: 64)
!152 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !153, line: 154, size: 160, elements: !154)
!153 = !DIFile(filename: "/usr/include/bpf/bpf_helpers.h", directory: "")
!154 = !{!155, !156, !157, !158, !159}
!155 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !152, file: !153, line: 155, baseType: !7, size: 32)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !152, file: !153, line: 156, baseType: !7, size: 32, offset: 32)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !152, file: !153, line: 157, baseType: !7, size: 32, offset: 64)
!158 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !152, file: !153, line: 158, baseType: !7, size: 32, offset: 96)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !152, file: !153, line: 159, baseType: !7, size: 32, offset: 128)
!160 = !{i32 7, !"Dwarf Version", i32 4}
!161 = !{i32 2, !"Debug Info Version", i32 3}
!162 = !{i32 1, !"wchar_size", i32 4}
!163 = !{!"clang version 10.0.0-4ubuntu1 "}
!164 = distinct !DISubprogram(name: "cookie_counter", scope: !3, file: !3, line: 31, type: !165, scopeLine: 31, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !167)
!165 = !DISubroutineType(types: !166)
!166 = !{!78}
!167 = !{}
!168 = !DILocation(line: 32, column: 12, scope: !164)
!169 = !DILocation(line: 32, column: 31, scope: !164)
!170 = !DILocation(line: 32, column: 5, scope: !164)
!171 = !DILocation(line: 0, scope: !104)
!172 = !DILocation(line: 37, column: 5, scope: !104)
!173 = !DILocation(line: 37, column: 23, scope: !104)
!174 = !{!175, !176, i64 0}
!175 = !{!"DataCookie", !176, i64 0, !176, i64 4, !179, i64 8, !179, i64 10, !176, i64 12, !180, i64 16}
!176 = !{!"int", !177, i64 0}
!177 = !{!"omnipotent char", !178, i64 0}
!178 = !{!"Simple C/C++ TBAA"}
!179 = !{!"short", !177, i64 0}
!180 = !{!"long long", !177, i64 0}
!181 = !DILocation(line: 37, column: 11, scope: !104)
!182 = !{!176, !176, i64 0}
!183 = !DILocation(line: 39, column: 49, scope: !104)
!184 = !DILocation(line: 39, column: 5, scope: !104)
!185 = !DILocation(line: 40, column: 5, scope: !186)
!186 = distinct !DILexicalBlock(scope: !104, file: !3, line: 40, column: 5)
!187 = !DILocation(line: 41, column: 1, scope: !104)
!188 = distinct !DISubprogram(name: "xdp_main", scope: !3, file: !3, line: 46, type: !189, scopeLine: 46, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !200)
!189 = !DISubroutineType(types: !190)
!190 = !{!191, !192}
!191 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!192 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !193, size: 64)
!193 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !194)
!194 = !{!195, !196, !197, !198, !199}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !193, file: !6, line: 2857, baseType: !78, size: 32)
!196 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !193, file: !6, line: 2858, baseType: !78, size: 32, offset: 32)
!197 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !193, file: !6, line: 2859, baseType: !78, size: 32, offset: 64)
!198 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !193, file: !6, line: 2861, baseType: !78, size: 32, offset: 96)
!199 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !193, file: !6, line: 2862, baseType: !78, size: 32, offset: 128)
!200 = !{!201, !202, !209, !210, !211}
!201 = !DILocalVariable(name: "ctx", arg: 1, scope: !188, file: !3, line: 46, type: !192)
!202 = !DILocalVariable(name: "Npack", scope: !188, file: !3, line: 47, type: !203)
!203 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "NetPacket", file: !3, line: 15, size: 256, elements: !204)
!204 = !{!205, !206, !207, !208}
!205 = !DIDerivedType(tag: DW_TAG_member, name: "ctx", scope: !203, file: !3, line: 16, baseType: !192, size: 64)
!206 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4", scope: !203, file: !3, line: 17, baseType: !61, size: 64, offset: 64)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "tcp", scope: !203, file: !3, line: 18, baseType: !80, size: 64, offset: 128)
!208 = !DIDerivedType(tag: DW_TAG_member, name: "eth", scope: !203, file: !3, line: 19, baseType: !44, size: 64, offset: 192)
!209 = !DILocalVariable(name: "ipv4", scope: !188, file: !3, line: 62, type: !61)
!210 = !DILocalVariable(name: "tcp", scope: !188, file: !3, line: 74, type: !80)
!211 = !DILocalVariable(name: "data_write", scope: !212, file: !3, line: 83, type: !108)
!212 = distinct !DILexicalBlock(scope: !213, file: !3, line: 82, column: 28)
!213 = distinct !DILexicalBlock(scope: !214, file: !3, line: 82, column: 12)
!214 = distinct !DILexicalBlock(scope: !215, file: !3, line: 81, column: 84)
!215 = distinct !DILexicalBlock(scope: !188, file: !3, line: 81, column: 9)
!216 = !DILocation(line: 0, scope: !188)
!217 = !DILocation(line: 49, column: 45, scope: !188)
!218 = !{!219, !176, i64 0}
!219 = !{!"xdp_md", !176, i64 0, !176, i64 4, !176, i64 8, !176, i64 12, !176, i64 16}
!220 = !DILocation(line: 49, column: 33, scope: !188)
!221 = !DILocation(line: 49, column: 17, scope: !188)
!222 = !DILocation(line: 52, column: 8, scope: !223)
!223 = distinct !DILexicalBlock(scope: !188, file: !3, line: 52, column: 8)
!224 = !DILocation(line: 52, column: 45, scope: !223)
!225 = !{!219, !176, i64 4}
!226 = !DILocation(line: 52, column: 33, scope: !223)
!227 = !DILocation(line: 52, column: 31, scope: !223)
!228 = !DILocation(line: 52, column: 8, scope: !188)
!229 = !DILocation(line: 57, column: 19, scope: !230)
!230 = distinct !DILexicalBlock(scope: !188, file: !3, line: 57, column: 8)
!231 = !{!232, !179, i64 12}
!232 = !{!"ethhdr", !177, i64 0, !177, i64 6, !179, i64 12}
!233 = !DILocation(line: 57, column: 27, scope: !230)
!234 = !DILocation(line: 57, column: 8, scope: !188)
!235 = !DILocation(line: 63, column: 21, scope: !236)
!236 = distinct !DILexicalBlock(scope: !188, file: !3, line: 63, column: 8)
!237 = !DILocation(line: 63, column: 8, scope: !236)
!238 = !DILocation(line: 63, column: 26, scope: !236)
!239 = !DILocation(line: 63, column: 8, scope: !188)
!240 = !DILocation(line: 69, column: 20, scope: !241)
!241 = distinct !DILexicalBlock(scope: !188, file: !3, line: 69, column: 8)
!242 = !{!243, !177, i64 9}
!243 = !{!"iphdr", !177, i64 0, !177, i64 0, !177, i64 1, !179, i64 2, !179, i64 4, !179, i64 6, !177, i64 8, !177, i64 9, !179, i64 10, !176, i64 12, !176, i64 16}
!244 = !DILocation(line: 69, column: 29, scope: !241)
!245 = !DILocation(line: 69, column: 8, scope: !188)
!246 = !DILocation(line: 75, column: 20, scope: !247)
!247 = distinct !DILexicalBlock(scope: !188, file: !3, line: 75, column: 8)
!248 = !DILocation(line: 75, column: 25, scope: !247)
!249 = !DILocation(line: 75, column: 8, scope: !188)
!250 = !DILocation(line: 81, column: 10, scope: !215)
!251 = !{!252, !179, i64 2}
!252 = !{!"tcphdr", !179, i64 0, !179, i64 2, !176, i64 4, !176, i64 8, !179, i64 12, !179, i64 12, !179, i64 13, !179, i64 13, !179, i64 13, !179, i64 13, !179, i64 13, !179, i64 13, !179, i64 13, !179, i64 13, !179, i64 14, !179, i64 16, !179, i64 18}
!253 = !DILocation(line: 81, column: 44, scope: !215)
!254 = !DILocation(line: 82, column: 23, scope: !213)
!255 = !DILocation(line: 82, column: 12, scope: !213)
!256 = !DILocation(line: 82, column: 12, scope: !214)
!257 = !DILocation(line: 83, column: 13, scope: !212)
!258 = !DILocation(line: 83, column: 31, scope: !212)
!259 = !DILocation(line: 84, column: 44, scope: !212)
!260 = !DILocation(line: 84, column: 24, scope: !212)
!261 = !DILocation(line: 84, column: 30, scope: !212)
!262 = !DILocation(line: 85, column: 44, scope: !212)
!263 = !{!243, !176, i64 16}
!264 = !DILocation(line: 85, column: 24, scope: !212)
!265 = !DILocation(line: 85, column: 30, scope: !212)
!266 = !{!175, !176, i64 4}
!267 = !DILocation(line: 86, column: 43, scope: !212)
!268 = !{!252, !179, i64 0}
!269 = !DILocation(line: 86, column: 24, scope: !212)
!270 = !DILocation(line: 86, column: 30, scope: !212)
!271 = !{!175, !179, i64 8}
!272 = !DILocation(line: 87, column: 24, scope: !212)
!273 = !DILocation(line: 87, column: 30, scope: !212)
!274 = !{!175, !179, i64 10}
!275 = !DILocation(line: 88, column: 33, scope: !212)
!276 = !{!252, !176, i64 4}
!277 = !DILocation(line: 88, column: 59, scope: !212)
!278 = !DILocation(line: 88, column: 24, scope: !212)
!279 = !DILocation(line: 88, column: 31, scope: !212)
!280 = !{!175, !176, i64 12}
!281 = !DILocation(line: 32, column: 12, scope: !164, inlinedAt: !282)
!282 = distinct !DILocation(line: 89, column: 31, scope: !212)
!283 = !DILocation(line: 32, column: 31, scope: !164, inlinedAt: !282)
!284 = !DILocation(line: 89, column: 24, scope: !212)
!285 = !DILocation(line: 89, column: 29, scope: !212)
!286 = !{!175, !180, i64 16}
!287 = !DILocation(line: 0, scope: !104, inlinedAt: !288)
!288 = distinct !DILocation(line: 91, column: 13, scope: !212)
!289 = !DILocation(line: 37, column: 5, scope: !104, inlinedAt: !288)
!290 = !DILocation(line: 37, column: 11, scope: !104, inlinedAt: !288)
!291 = !DILocation(line: 39, column: 5, scope: !104, inlinedAt: !288)
!292 = !DILocation(line: 40, column: 5, scope: !186, inlinedAt: !288)
!293 = !DILocation(line: 41, column: 1, scope: !104, inlinedAt: !288)
!294 = !DILocation(line: 93, column: 9, scope: !213)
!295 = !DILocation(line: 103, column: 1, scope: !188)
