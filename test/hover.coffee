target = null

beforeEach ->
  target = null

describe 'Hover Event Handling', ->

  beforeEach ->
    spyOn(MyLib, 'onHover').andCallFake -> target = @
    fixture """
      <div id="parent">
        <div id="test" data-on-hover="MyLib.onHover">
          <div id="child">Test</div>
        </div>
      </div>
      """

  describe 'with a hover delay of 10ms', ->
    beforeEach ->
      $.fastbinder.setOptions({ hoverDelay: 10 })

    it 'should handle hovers on the element with a delay', ->
      $('#test').mousemove()
      expect(MyLib.onHover).not.toHaveBeenCalled()
      waits(20)
      runs ->
        expect(MyLib.onHover).toHaveBeenCalled()
        expect(target).toBe $('#test')[0]

  describe 'without a hover delay', ->
    beforeEach ->
      $.fastbinder.setOptions({ hoverDelay: 0 })

    it 'should handle hovers on the element', ->
      $('#test').mousemove()
      expect(MyLib.onHover).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

    it 'should handle hovers on a child element', ->
      $('#child').mousemove()
      expect(MyLib.onHover).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

    it 'should ignore hovers on a parent element', ->
      $('#parent').mousemove()
      expect(MyLib.onHover).not.toHaveBeenCalled()
