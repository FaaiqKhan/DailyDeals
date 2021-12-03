import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  /// the child widget for the button, this will be ignored if text is supplied
  final Widget? child;

  /// onChange is called when the selected option is changed.;
  /// It will pass back the value and the index of the option.
  final void Function(T, int)? onChange;

  /// list of DropdownItems
  final List<Widget>? items;
  final DropdownStyle dropdownStyle;

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  final DropdownButtonStyle dropdownButtonStyle;

  /// dropdown button icon defaults to caret
  final Icon? icon;
  final bool hideIcon;

  /// if true the dropdown icon will as a leading icon, default to false
  final bool leadingIcon;

  CustomDropdown({
    Key? key,
    this.hideIcon = false,
    @required this.child,
    @required this.items,
    this.dropdownStyle = const DropdownStyle(),
    this.dropdownButtonStyle = const DropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
    this.onChange,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  AnimationController? _animationController;
  Animation<double>? _expandAnimation;
  Animation<double>? _rotateAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.25).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DropdownButtonStyle style = widget.dropdownButtonStyle;
    // link the overlay to the button
    return CompositedTransformTarget(
      link: this._layerLink,
      child: Container(
        width: style.width,
        height: style.height,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: style.padding,
            backgroundColor: _isOpen
                ? style.backgroundColor.first
                : style.backgroundColor.last,
            elevation: style.elevation,
            // shape: style.shape,
          ),
          onPressed: _toggleDropdown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection:
                widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
            children: [
              if (_currentIndex == -1) ...[
                widget.child!,
              ] else ...[
                widget.items![_currentIndex],
              ],
              if (!widget.hideIcon)
                Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: RotationTransition(
                    turns: _rotateAnimation!,
                    child: widget.icon ??
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Colors.white,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    return OverlayEntry(
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: topOffset,
              width: widget.dropdownStyle.width ?? size.width,
              child: CompositedTransformFollower(
                offset:
                    widget.dropdownStyle.offset ?? Offset(0, size.height + 5),
                link: this._layerLink,
                showWhenUnlinked: false,
                child: Material(
                  elevation: widget.dropdownStyle.elevation,
                  borderRadius: widget.dropdownStyle.borderRadius,
                  color: widget.dropdownStyle.color,
                  child: SizeTransition(
                    axisAlignment: 1,
                    sizeFactor: _expandAnimation!,
                    child: ConstrainedBox(
                      constraints: widget.dropdownStyle.constraints ??
                          BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height -
                                topOffset -
                                15,
                          ),
                      child: ListView(
                        padding:
                            widget.dropdownStyle.padding ?? EdgeInsets.zero,
                        shrinkWrap: true,
                        children: widget.items!,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController!.reverse();
      this._overlayEntry!.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context)!.insert(this._overlayEntry!);
      setState(() => _isOpen = true);
      _animationController!.forward();
    }
  }
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final ShapeBorder? shape;
  final double? elevation;
  final List<Color> backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;

  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor = const [Colors.black, Colors.white],
    this.constraints,
    this.elevation,
    this.padding,
    this.height,
    this.width,
    this.shape,
  });
}

class DropdownStyle {
  final BorderRadius borderRadius;
  final double elevation;
  final Color color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset? offset;

  ///button width must be set for this to take effect
  final double? width;

  const DropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.elevation = 0,
    this.color = Colors.white,
    this.padding,
    this.borderRadius = BorderRadius.zero,
  });
}
