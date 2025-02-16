BINS_qpdf = \
    qpdf \
    fix-qdf \
    pdf_from_scratch \
    test_driver \
    test_large_file \
    test_parsedoffset \
    test_pdf_doc_encoding \
    test_pdf_unicode \
    test_renumber \
    test_shell_glob \
    test_tokenizer \
    test_unicode_filenames \
    test_xref
CBINS_qpdf = \
    qpdf-ctest \
    qpdfjob-ctest

TARGETS_qpdf = $(foreach B,$(BINS_qpdf) $(CBINS_qpdf),qpdf/$(OUTPUT_DIR)/$(call binname,$(B)))

$(TARGETS_qpdf): $(TARGETS_libqpdf)

INCLUDES_qpdf = include

TC_SRCS_qpdf = $(wildcard libqpdf/*.cc) $(wildcard qpdf/*.cc)

# -----

define use_wmain
  XCXXFLAGS_qpdf_$(1) := $(WINDOWS_WMAIN_COMPILE)
  XLDFLAGS_qpdf_$(1) := $(WINDOWS_WMAIN_LINK)
  XLINK_FLAGS_qpdf_$(1) := $(WINDOWS_WMAIN_XLINK_FLAGS)
endef

$(foreach B,qpdf test_unicode_filenames fix-qdf test_shell_glob,\
  $(eval $(call use_wmain,$(B))))

$(foreach B,$(BINS_qpdf),$(eval \
  OBJS_$(B) = $(call src_to_obj,qpdf/$(B).cc)))
$(foreach B,$(CBINS_qpdf),$(eval \
  OBJS_$(B) = $(call c_src_to_obj,qpdf/$(B).c)))

ifeq ($(GENDEPS),1)
-include $(foreach B,$(BINS_qpdf) $(CBINS_qpdf),$(call obj_to_dep,$(OBJS_$(B))))
endif

$(foreach B,$(BINS_qpdf),$(eval \
  $(OBJS_$(B)): qpdf/$(OUTPUT_DIR)/%.$(OBJ): qpdf/$(B).cc ; \
	$(call compile,qpdf/$(B).cc,$(INCLUDES_qpdf),$(XCXXFLAGS_qpdf_$(B)))))

$(foreach B,$(CBINS_qpdf),$(eval \
  $(OBJS_$(B)): qpdf/$(OUTPUT_DIR)/%.$(OBJ): qpdf/$(B).c ; \
	$(call c_compile,qpdf/$(B).c,$(INCLUDES_qpdf),$(XCFLAGS_qpdf_$(B)))))

$(foreach B,$(BINS_qpdf) $(CBINS_qpdf),$(eval \
  qpdf/$(OUTPUT_DIR)/$(call binname,$(B)): $(OBJS_$(B)) ; \
	$(call makebin,$(OBJS_$(B)),$$@,$(LDFLAGS_libqpdf) $(LDFLAGS) $(XLDFLAGS_qpdf_$(B)),$(LIBS_libqpdf) $(LIBS),$(XLINK_FLAGS_qpdf_$(B)))))
