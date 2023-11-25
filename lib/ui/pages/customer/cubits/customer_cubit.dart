import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/ui/pages/customer/states/customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(const CustomerState());
}
