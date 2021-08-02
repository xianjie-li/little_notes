
import 'package:flutter/cupertino.dart';

FormFieldValidator<String> combineValidator(List<FormFieldValidator<String>> validatorList) {
  return (val) {
    for (int i = 0; i < validatorList.length; i++) {
      var current = validatorList[i];
      var ret = current(val);
      if (ret is String) return ret;
    }
  };
}

FormFieldValidator<String> notEmptyStringValidatorGetter([String tipStr = '不能为空']) {
  return (val) => val == null || val.isEmpty ? tipStr : null;
}

FormFieldValidator<String> isNumberValidatorGetter([String tipStr = '必须为数字']) {
  return (val) {
    num? n = num.tryParse(val ?? '');
    if (n == null) return tipStr;
  };
}
