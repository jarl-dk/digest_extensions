#include "ruby/digest.h"

#include "digest_extensions_helper.h"

static VALUE rb_mDigest;
static VALUE rb_mDigest_Instance;


#define hex(c) ((c>='a')?c-'a'+10:(c>='A')?c-'A'+10:c-'0') 

/*
 * Document-module: Digest::Instance
 *
 * This module provides instance methods for a digest implementation
 * object to calculate message digest values.
 */

/*
 * call-seq:
 *     digest_obj.marshal_dump() -> byte sequence
 *
 * dumps the state as a byte sequence
 *
 */
static VALUE
rb_digest_instance_marshal_dump(VALUE self)
{
  rb_digest_metadata_t *algo;
  void *pctx;
  VALUE str;
  size_t i;
  char *p;
  static const char hex[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };


  algo = get_digest_base_metadata(rb_obj_class(self));

  /* Data_Get_Struct(obj, rb_digest_metadata_t, algo); */
  pctx = xmalloc(algo->ctx_size);
  Data_Get_Struct(self, void, pctx);
  /* //    rb_digest_instance_method_unimpl(self, "update"); */

  str = rb_str_new(0, algo->ctx_size * 2); 
  for (i = 0, p = RSTRING_PTR(str); i < algo->ctx_size; ++i) {
    unsigned char byte = ((unsigned char*)pctx)[i];
    p[i + i]     = hex[byte >> 4];
    p[i + i + 1] = hex[byte & 0x0f];
  }
  
  return str;
}

/*
 * call-seq:
 *     digest_obj.marshal_load(byte_sequence) ->
 *
 * loads the state as a byte sequence
 *
 */
static VALUE
rb_digest_instance_marshal_load(VALUE self, VALUE byte_sequence)
{
  rb_digest_metadata_t *algo;
  size_t byte_counter;
  void *pctx;
  unsigned char* from;

  algo = get_digest_base_metadata(rb_obj_class(self));

  if((size_t)RSTRING_LEN(byte_sequence) != algo->ctx_size *2){
    rb_raise(rb_eRuntimeError, "Digest::Base#marshal_load: length is incorrect.");
  }

  from =  RSTRING_PTR(byte_sequence);
  Data_Get_Struct(self, void, pctx);

  for(byte_counter = 0; byte_counter < algo->ctx_size; ++byte_counter){
    unsigned char hex_digit_1 = from[byte_counter *2];
    unsigned char hex_digit_2 = from[byte_counter *2 + 1];
    if(( ('a' <= hex_digit_1 && hex_digit_1 <= 'f' )
         || ('0' <= hex_digit_1 && hex_digit_1 <= '9' ))
       &&(('a' <= hex_digit_2 && hex_digit_2 <= 'f' )
          || ('0' <= hex_digit_2 && hex_digit_2 <= '9' ))){
      ((unsigned char*)pctx)[byte_counter] = (hex(hex_digit_1)<<4) + hex(hex_digit_2);
    }else{
      rb_raise(rb_eRuntimeError, "Digest::Base#marshal_load: Not a hexadecimal digit.");
    }
  }
  return Qnil;
}

void
Init_digest_extensions(void)
{

  id_metadata = rb_intern("metadata");//This is an initializer for the helper functions.

  /*
   * module Digest
   */
  rb_mDigest = rb_define_module("Digest");
  
  /*
   * module Digest::Instance
   */
  rb_mDigest_Instance = rb_define_module_under(rb_mDigest, "Instance");
  
  rb_define_method(rb_mDigest_Instance, "marshal_dump", rb_digest_instance_marshal_dump, 0);
  rb_define_method(rb_mDigest_Instance, "marshal_load", rb_digest_instance_marshal_load, 1);
  
}
