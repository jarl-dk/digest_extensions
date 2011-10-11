static ID id_metadata;

static rb_digest_metadata_t *
get_digest_base_metadata(VALUE klass)
{
    VALUE p;
    VALUE obj;
    rb_digest_metadata_t *algo;

    for (p = klass; p; p = RCLASS_SUPER(p)) {
        if (rb_ivar_defined(p, id_metadata)) {
            obj = rb_ivar_get(p, id_metadata);
            break;
        }
    }

    if (!p)
        rb_raise(rb_eRuntimeError, "Digest::Base cannot be directly inherited in Ruby");

    Data_Get_Struct(obj, rb_digest_metadata_t, algo);

    switch (algo->api_version) {
      case 2:
        break;

      /*
       * put conversion here if possible when API is updated
       */

      default:
        rb_raise(rb_eRuntimeError, "Incompatible digest API version");
    }

    return algo;
}
