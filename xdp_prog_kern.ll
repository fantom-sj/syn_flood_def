; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@xdp_stats_map = dso_local global %struct.bpf_map_def { i32 2, i32 4, i32 8, i32 5, i32 0 }, section "maps", align 4, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !15
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_stats1_func to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_stats1_func(%struct.xdp_md* nocapture readnone %0) #0 section "xdp_stats1" !dbg !42 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !57, metadata !DIExpression()), !dbg !67
  %3 = bitcast i32* %2 to i8*, !dbg !68
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #3, !dbg !68
  call void @llvm.dbg.value(metadata i32 2, metadata !66, metadata !DIExpression()), !dbg !67
  store i32 2, i32* %2, align 4, !dbg !69, !tbaa !70
  call void @llvm.dbg.value(metadata i32* %2, metadata !66, metadata !DIExpression(DW_OP_deref)), !dbg !67
  %4 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %3) #3, !dbg !74
  call void @llvm.dbg.value(metadata i8* %4, metadata !58, metadata !DIExpression()), !dbg !67
  %5 = icmp eq i8* %4, null, !dbg !75
  br i1 %5, label %9, label %6, !dbg !77

6:                                                ; preds = %1
  call void @llvm.dbg.value(metadata i8* %4, metadata !58, metadata !DIExpression()), !dbg !67
  %7 = bitcast i8* %4 to i64*, !dbg !78
  %8 = atomicrmw add i64* %7, i64 1 seq_cst, !dbg !78
  br label %9, !dbg !79

9:                                                ; preds = %1, %6
  %10 = phi i32 [ 2, %6 ], [ 0, %1 ], !dbg !67
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #3, !dbg !80
  ret i32 %10, !dbg !80
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!38, !39, !40}
!llvm.ident = !{!41}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 11, type: !30, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/basic03-map-counter")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/basic03-map-counter")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !{!0, !15, !21}
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 56, type: !17, isLocal: false, isDefinition: true)
!17 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 32, elements: !19)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!19 = !{!20}
!20 = !DISubrange(count: 4)
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !23, line: 51, type: !24, isLocal: true, isDefinition: true)
!23 = !DIFile(filename: "/usr/include/bpf/bpf_helper_defs.h", directory: "")
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DISubroutineType(types: !26)
!26 = !{!27, !27, !28}
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!30 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !31, line: 154, size: 160, elements: !32)
!31 = !DIFile(filename: "/usr/include/bpf/bpf_helpers.h", directory: "")
!32 = !{!33, !34, !35, !36, !37}
!33 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !30, file: !31, line: 155, baseType: !7, size: 32)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !30, file: !31, line: 156, baseType: !7, size: 32, offset: 32)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !30, file: !31, line: 157, baseType: !7, size: 32, offset: 64)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !30, file: !31, line: 158, baseType: !7, size: 32, offset: 96)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !30, file: !31, line: 159, baseType: !7, size: 32, offset: 128)
!38 = !{i32 7, !"Dwarf Version", i32 4}
!39 = !{i32 2, !"Debug Info Version", i32 3}
!40 = !{i32 1, !"wchar_size", i32 4}
!41 = !{!"clang version 10.0.0-4ubuntu1 "}
!42 = distinct !DISubprogram(name: "xdp_stats1_func", scope: !3, file: !3, line: 26, type: !43, scopeLine: 27, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !56)
!43 = !DISubroutineType(types: !44)
!44 = !{!45, !46}
!45 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!47 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !48)
!48 = !{!49, !52, !53, !54, !55}
!49 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !47, file: !6, line: 2857, baseType: !50, size: 32)
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !51, line: 27, baseType: !7)
!51 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!52 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !47, file: !6, line: 2858, baseType: !50, size: 32, offset: 32)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !47, file: !6, line: 2859, baseType: !50, size: 32, offset: 64)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !47, file: !6, line: 2861, baseType: !50, size: 32, offset: 96)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !47, file: !6, line: 2862, baseType: !50, size: 32, offset: 128)
!56 = !{!57, !58, !66}
!57 = !DILocalVariable(name: "ctx", arg: 1, scope: !42, file: !3, line: 26, type: !46)
!58 = !DILocalVariable(name: "rec", scope: !42, file: !3, line: 30, type: !59)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !61, line: 8, size: 64, elements: !62)
!61 = !DIFile(filename: "./common_kern_user.h", directory: "/home/admin-ub/\D0\94\D0\BE\D0\BA\D1\83\D0\BC\D0\B5\D0\BD\D1\82\D1\8B/xdp-tutorial/basic03-map-counter")
!62 = !{!63}
!63 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !60, file: !61, line: 9, baseType: !64, size: 64)
!64 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !51, line: 31, baseType: !65)
!65 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!66 = !DILocalVariable(name: "key", scope: !42, file: !3, line: 31, type: !50)
!67 = !DILocation(line: 0, scope: !42)
!68 = !DILocation(line: 31, column: 2, scope: !42)
!69 = !DILocation(line: 31, column: 8, scope: !42)
!70 = !{!71, !71, i64 0}
!71 = !{!"int", !72, i64 0}
!72 = !{!"omnipotent char", !73, i64 0}
!73 = !{!"Simple C/C++ TBAA"}
!74 = !DILocation(line: 34, column: 8, scope: !42)
!75 = !DILocation(line: 39, column: 7, scope: !76)
!76 = distinct !DILexicalBlock(scope: !42, file: !3, line: 39, column: 6)
!77 = !DILocation(line: 39, column: 6, scope: !42)
!78 = !DILocation(line: 45, column: 2, scope: !42)
!79 = !DILocation(line: 53, column: 2, scope: !42)
!80 = !DILocation(line: 54, column: 1, scope: !42)
